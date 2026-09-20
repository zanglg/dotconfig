-- From the config repository: nvim --headless -u NONE -l nvim/tests/quickfix.lua
vim.opt.rtp:prepend(vim.fn.getcwd() .. "/nvim")
require("options")
local quickfix = require("quickfix")

local root = vim.fn.tempname()
vim.fn.mkdir(root, "p")
root = assert(vim.uv.fs_realpath(root))
vim.fn.writefile({ "needle alpha", "needle Beta", "nothing" }, root .. "/one.txt")
vim.fn.writefile({ "needle gamma" }, root .. "/two file.txt")
local original_cwd = vim.fn.getcwd()
local original_jobstart, original_jobstop = vim.fn.jobstart, vim.fn.jobstop
local original_notify = vim.notify
local notifications = {}
vim.notify = function(message, level)
    notifications[#notifications + 1] = { message = message, level = level }
end

local function equal(expected, actual)
    assert(vim.deep_equal(expected, actual), vim.inspect({ expected = expected, actual = actual }))
end
local function qf()
    return vim.fn.getqflist({ id = 0, nr = 0, items = 0, title = 0, context = 0, winid = 0 })
end
local function press(key)
    local mapping = vim.fn.maparg(key, "n", false, true)
    assert(mapping.buffer == 1 and type(mapping.callback) == "function", "Missing mapping: " .. key)
    mapping.callback()
end
local function wait_for(predicate)
    assert(vim.wait(5000, predicate, 10), "Timed out waiting for grep")
end
local finished
vim.fn.jobstart = function(command, opts)
    finished = false
    local on_exit = opts.on_exit
    opts.on_exit = function(...)
        on_exit(...)
        vim.schedule(function()
            finished = true
        end)
    end
    return original_jobstart(command, opts)
end
local function search(query)
    quickfix.grep(query)
    wait_for(function()
        return finished
    end)
end

local function run()
    vim.cmd.cd(root)
    search("needle")
    equal(3, #qf().items)
    assert(qf().winid ~= 0)
    local first = qf()
    for _, item in ipairs(first.items) do
        equal(1, item.valid)
        equal(1, item.col)
        assert(vim.api.nvim_buf_get_name(item.bufnr):find(root, 1, true) == 1)
    end

    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    press("dd")
    equal(first.id, qf().id)
    equal(first.nr, qf().nr)
    equal(2, #qf().items)
    equal(first.context, qf().context)

    search("needle")
    local unfiltered = qf()
    vim.fn.setreg("/", "beta")
    press("gk")
    equal(1, #qf().items)
    equal("needle Beta", qf().items[1].text)
    equal(unfiltered.nr + 1, qf().nr)
    equal(unfiltered.context, qf().context)
    press("<C-o>")
    equal(unfiltered.id, qf().id)
    press("<C-i>")
    equal(1, #qf().items)
    press("<C-o>")
    vim.fn.setreg("/", "Beta")
    press("gd")
    equal(2, #qf().items)
    press("<C-o>")
    vim.fn.setreg("/", [[\CBETA]])
    press("gk")
    equal(0, #qf().items)
    press("<C-o>")
    vim.fn.setreg("/", [[\cBETA]])
    press("gk")
    equal(1, #qf().items)
    press("dd")
    equal(0, #qf().items)

    search("missing-pattern")
    equal(0, #qf().items)
    equal("No matches: missing-pattern", notifications[#notifications].message)
    search("[")
    equal(vim.log.levels.ERROR, notifications[#notifications].level)
    assert(notifications[#notifications].message:find("regex parse error", 1, true))

    -- Deterministic chunking/cancellation tests without a running process.
    local jobs, stopped = {}, {}
    vim.fn.jobstart = function(command, opts)
        equal(root, command[#command])
        equal(root, opts.cwd)
        jobs[#jobs + 1] = opts
        return #jobs
    end
    vim.fn.jobstop = function(id)
        stopped[id] = true
        return 1
    end
    local function emit(job, text)
        job.on_stdout(0, { root .. "/one.txt:1:1:" .. text, "" })
    end

    vim.cmd.cclose()
    quickfix.grep("chunks")
    local chunks = jobs[#jobs]
    chunks.on_stdout(0, { root .. "/one.txt:1:" })
    chunks.on_stdout(0, { "1:needle al" })
    chunks.on_stdout(0, { "pha", root .. "/two file.txt:1:1:needle gamma", "" })
    equal(0, #qf().items) -- no per-callback redraw
    vim.cmd.cd(original_cwd) -- output must still resolve against the search cwd
    wait_for(function()
        return #qf().items == 2
    end)
    equal("needle alpha", qf().items[1].text)
    equal(root .. "/one.txt", vim.api.nvim_buf_get_name(qf().items[1].bufnr))
    assert(qf().winid ~= 0)
    quickfix.toggle()
    emit(chunks, "later")
    wait_for(function()
        return #qf().items == 3
    end)
    equal(0, qf().winid) -- no reopening after manual close
    vim.cmd.cd(root)
    quickfix.toggle()
    vim.api.nvim_win_set_cursor(0, { 3, 0 })
    press("dd")
    equal(2, #qf().items)
    emit(chunks, "pending")
    vim.fn.setreg("/", "needle")
    press("gk") -- flush pending complete lines, stop job, then create history
    assert(stopped[#jobs])
    equal(2, #qf().items)
    emit(chunks, "cancelled")
    chunks.on_exit(0, 0)
    vim.wait(80, function() return false end)
    equal(2, #qf().items)
    press("<C-o>")
    equal(3, #qf().items)

    quickfix.grep("old")
    local old = jobs[#jobs]
    local old_id = qf().id
    emit(old, "preserved")
    quickfix.grep("new")
    equal(1, #vim.fn.getqflist({ id = old_id, items = 0 }).items)
    emit(old, "late")
    old.on_exit(0, 0)
    equal(0, #qf().items)
    local new = jobs[#jobs]
    -- Finish with an unterminated final record.
    new.on_stdout(0, { root .. "/one.txt:1:1:final" })
    new.on_exit(0, 0)
    wait_for(function() return #qf().items == 1 end)
    equal("final", qf().items[1].text)

    quickfix.grep("background")
    local background = jobs[#jobs]
    local background_id = qf().id
    press("<C-o>")
    local displayed_id = qf().id
    vim.cmd.cclose()
    emit(background, "background result")
    wait_for(function()
        return #vim.fn.getqflist({ id = background_id, items = 0 }).items == 1
    end)
    equal(displayed_id, qf().id)
    equal(0, qf().winid)
    -- Freeing the stack must not let a pending callback recreate it.
    vim.fn.setqflist({}, "f")
    emit(background, "discarded")
    vim.wait(80, function() return false end)
    equal(0, qf().id)
    assert(stopped[#jobs])

    -- qf FileType is shared with location lists: don't install global-list edits.
    vim.fn.setloclist(0, { { filename = root .. "/one.txt", lnum = 1, text = "local" } })
    vim.cmd.lopen()
    equal({}, vim.fn.maparg("dd", "n", false, true))
    vim.cmd.lclose()
end

local ok, err = xpcall(run, debug.traceback)
-- Stop any fake job before restoring jobstop (fake IDs are not real jobs).
vim.api.nvim_exec_autocmds("VimLeavePre", { group = "config-quickfix" })
vim.fn.jobstart, vim.fn.jobstop = original_jobstart, original_jobstop
vim.notify = original_notify
vim.cmd.cd(original_cwd)
vim.fn.delete(root, "rf")
if not ok then
    error(err)
end
print("quickfix tests passed")
