-- Quickfix-first project search. Native /, n and N are left untouched.
-- <leader>/ prompts for a regex; <leader>? greps <cword>; q toggles quickfix.
-- In quickfix: dd deletes, gd/gk delete/keep / matches, Ctrl-O/Ctrl-I browse history.
-- rg streams into one history entry, batched every 50ms; dd edits it in place;
-- gd/gk freeze and create a new entry. Filesystem errors are ignored, regex errors aren't.
local M = {}
local active_grep

local function current_quickfix()
    return vim.fn.getqflist({ id = 0, items = 0, title = 0, context = 0, qfbufnr = 0 })
end

function M.toggle()
    local qf = vim.fn.getqflist({ winid = 0, size = 0 })
    if qf.winid ~= 0 then
        vim.cmd("silent! cclose")
    elseif qf.size == 0 then
        vim.notify("Quickfix is empty", vim.log.levels.INFO)
    else
        vim.cmd("silent! copen")
    end
end

local function stop_timer(ctx)
    if ctx.timer then
        ctx.timer:stop()
        if not ctx.timer:is_closing() then
            ctx.timer:close()
        end
        ctx.timer = nil
    end
end

local function stop_active_grep(flush_pending)
    local ctx = active_grep
    if not ctx then
        return
    end

    stop_timer(ctx)
    if flush_pending then
        -- Only complete records are safe to preserve when cancelling a job.
        -- Do not open/focus a window while freezing a background search.
        ctx.flush(false)
    end
    ctx.cancelled = true
    if ctx.job_id and ctx.job_id > 0 then
        pcall(vim.fn.jobstop, ctx.job_id)
    end
    if active_grep == ctx then
        active_grep = nil
    end
end

function M.grep(query)
    if not query or query == "" then
        return
    end
    if vim.fn.executable("rg") ~= 1 then
        vim.notify("ripgrep (rg) is not installed", vim.log.levels.ERROR)
        return
    end

    stop_active_grep(true)
    local cwd = vim.fn.getcwd()
    vim.fn.setqflist({}, " ", {
        title = "rg: " .. query,
        items = {},
        context = { query = query, cwd = cwd },
    })

    local ctx = {
        qf_id = vim.fn.getqflist({ id = 0 }).id,
        tab = vim.api.nvim_get_current_tabpage(),
        cancelled = false,
        pending = {},
        partial = "",
        opened = vim.fn.getqflist({ winid = 0 }).winid ~= 0,
        stderr = {},
    }
    active_grep = ctx

    local function flush(open_window)
        if ctx.cancelled or #ctx.pending == 0 then
            return
        end

        -- Lists can be removed by branching history or setqflist({}, "f").
        -- Never let a late callback recreate a discarded list.
        if vim.fn.getqflist({ id = ctx.qf_id }).id ~= ctx.qf_id then
            stop_active_grep(false)
            return
        end

        local lines = ctx.pending
        ctx.pending = {}
        local ok, result = pcall(vim.fn.setqflist, {}, "a", {
            id = ctx.qf_id,
            lines = lines,
            efm = "%f:%l:%c:%m",
        })
        if not ok or result ~= 0 then
            stop_active_grep(false)
            return
        end

        -- Only open once, and only if this is still the displayed list/tab.
        -- Manual closing and history navigation must not be undone by rg.
        if open_window and not ctx.opened then
            ctx.opened = true
            if vim.api.nvim_get_current_tabpage() == ctx.tab
                and vim.fn.getqflist({ id = 0 }).id == ctx.qf_id
            then
                vim.cmd("silent! copen")
            end
        end
    end
    ctx.flush = flush

    local function schedule_flush()
        if ctx.cancelled or ctx.timer then
            return
        end
        ctx.timer = vim.defer_fn(function()
            ctx.timer = nil
            flush(true)
        end, 50)
    end

    local function consume_stdout(data)
        if ctx.cancelled or not data or #data == 0 then
            return
        end
        -- jobstart's first/last elements can be fragments of a single line.
        if #data == 1 then
            ctx.partial = ctx.partial .. data[1]
            return
        end
        local first = ctx.partial .. data[1]
        if first ~= "" then
            ctx.pending[#ctx.pending + 1] = first
        end
        for i = 2, #data - 1 do
            if data[i] ~= "" then
                ctx.pending[#ctx.pending + 1] = data[i]
            end
        end
        ctx.partial = data[#data]
        schedule_flush()
    end

    local ok, job_id = pcall(vim.fn.jobstart, {
        "rg",
        "--no-config",
        "--vimgrep",
        "--color=never",
        "--line-buffered",
        "--smart-case",
        "--follow",
        "--no-messages",
        "--",
        query,
        -- Absolute filenames remain valid if :cd/:lcd changes during the job.
        cwd,
    }, {
        cwd = cwd,
        stdout_buffered = false,
        stderr_buffered = true,
        on_stdout = function(_, data)
            consume_stdout(data)
        end,
        on_stderr = function(_, data)
            if not ctx.cancelled then
                ctx.stderr = data or {}
            end
        end,
        on_exit = function(_, code)
            vim.schedule(function()
                if ctx.cancelled then
                    return
                end
                stop_timer(ctx)
                if ctx.partial ~= "" then
                    ctx.pending[#ctx.pending + 1] = ctx.partial
                    ctx.partial = ""
                end
                flush(true)
                if active_grep == ctx then
                    active_grep = nil
                end
                if ctx.cancelled then
                    return
                end

                local stderr = vim.trim(table.concat(ctx.stderr, "\n"))
                if code == 1 then
                    vim.notify("No matches: " .. query, vim.log.levels.INFO)
                elseif code ~= 0 and stderr ~= "" then
                    vim.notify(stderr, vim.log.levels.ERROR)
                end
            end)
        end,
    })
    if not ok or job_id <= 0 then
        stop_active_grep(false)
        vim.notify("Failed to start ripgrep", vim.log.levels.ERROR)
        return
    end
    ctx.job_id = job_id
end

function M.grep_project()
    -- Treat Ctrl-C as cancellation rather than an error from the mapping.
    local ok, query = pcall(vim.fn.input, "Grep: ")
    if ok then
        M.grep(query)
    end
end

function M.grep_current_word()
    M.grep(vim.fn.expand("<cword>"))
end

-- match() obeys ignorecase, but not smartcase. Approximate native / casing;
-- an explicit \c or \C in the pattern still takes precedence over this prefix.
-- Filtering is line-wise: buffer-position/multiline search atoms aren't /-exact.
local function effective_search_pattern(pattern)
    if not vim.o.ignorecase or (vim.o.smartcase and pattern:find("%u")) then
        return "\\C" .. pattern
    end
    return "\\c" .. pattern
end

local function delete_entry()
    local qf = current_quickfix()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    if row > #qf.items then
        return
    end
    table.remove(qf.items, row)
    local idx = math.min(row, #qf.items)
    vim.fn.setqflist({}, "r", {
        id = qf.id,
        items = qf.items,
        idx = idx,
        title = qf.title,
        context = qf.context,
    })
    if idx > 0 then
        pcall(vim.api.nvim_win_set_cursor, 0, { idx, 0 })
    end
end

local function filter_quickfix(keep_matches)
    local pattern = vim.fn.getreg("/")
    if pattern == "" then
        vim.notify("No / search pattern", vim.log.levels.WARN)
        return
    end
    local match_pattern = effective_search_pattern(pattern)
    local ok, err = pcall(vim.fn.match, "", match_pattern)
    if not ok then
        vim.notify("Invalid / search pattern: " .. tostring(err), vim.log.levels.ERROR)
        return
    end

    stop_active_grep(true)
    local qf = current_quickfix()
    if #qf.items == 0 then
        return
    end
    -- Match exactly the displayed filename/location/text, not just item.text.
    local lines = vim.api.nvim_buf_get_lines(qf.qfbufnr, 0, -1, false)
    if #lines ~= #qf.items then
        vim.notify("Quickfix buffer and list are out of sync", vim.log.levels.ERROR)
        return
    end

    local filtered = {}
    for i, item in ipairs(qf.items) do
        if (vim.fn.match(lines[i], match_pattern) >= 0) == keep_matches then
            filtered[#filtered + 1] = item
        end
    end
    vim.fn.setqflist({}, " ", {
        items = filtered,
        context = qf.context,
        title = string.format("%s /%s/", keep_matches and "keep" or "delete", pattern),
    })
end

local function history(delta)
    local current = vim.fn.getqflist({ nr = 0 }).nr
    local last = vim.fn.getqflist({ nr = "$" }).nr
    if current + delta >= 1 and current + delta <= last then
        vim.cmd(delta < 0 and "silent! colder" or "silent! cnewer")
    end
end

local group = vim.api.nvim_create_augroup("config-quickfix", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "qf",
    callback = function(event)
        -- Location lists share filetype=qf, but these operations are global.
        local info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
        if not info or info.loclist == 1 then
            return
        end
        vim.wo.winfixheight = true
        local function map(key, callback, desc)
            vim.keymap.set("n", key, callback, { buffer = event.buf, silent = true, desc = desc })
        end
        map("q", "<cmd>silent! cclose<cr>", "Close quickfix")
        map("dd", delete_entry, "Delete quickfix entry")
        map("gd", function()
            filter_quickfix(false)
        end, "Delete entries matching / search")
        map("gk", function()
            filter_quickfix(true)
        end, "Keep entries matching / search")
        map("<C-o>", function()
            history(-1)
        end, "Previous quickfix list")
        -- In many terminals Ctrl-I and Tab are the same key.
        map("<C-i>", function()
            history(1)
        end, "Next quickfix list")
    end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
        stop_active_grep(false)
    end,
})

return M
