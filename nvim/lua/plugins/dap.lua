return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
    },
    keys = {
        { "<leader>do",  function() require('dapui').toggle() end,          desc = "Debug Open",        mode = { "n" } },
        { "<leader>dc",  function() require('dap').continue() end,          desc = "Continue",          mode = { "n" } },

        { "<leader>dsn", function() require('dap').step_over() end,         desc = "Step Over",         mode = { "n" } },
        { "<leader>dsi", function() require('dap').step_into() end,         desc = "Step Into",         mode = { "n" } },
        { "<leader>dso", function() require('dap').step_out() end,          desc = "Step Out",          mode = { "n" } },
        { "<leader>dsb", function() require('dap').step_back() end,         desc = "Step Back",         mode = { "n" } },

        { "<leader>dbt", function() require('dap').toggle_breakpoint() end, desc = "Toggle Breakpoint", mode = { "n" } },
        { "<leader>dbs", function() require('dap').set_breakpoint() end,    desc = "Set Breakpoint",    mode = { "n" } },
    },
    config = function()
        local dap = require("dap")

        local lldb = "/usr/bin/lldb-vscode"
        if vim.loop.os_uname().sysname == "Darwin" then
            lldb = "/usr/local/opt/llvm/bin/lldb-vscode"
        end

        dap.adapters.lldb = {
            type = "executable",
            command = lldb,
            name = "lldb",
        }

        dap.configurations.rust = {
            {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                initCommands = function()
                    -- Find out where to look for the pretty printer Python module
                    local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

                    local script_import = 'command script import "' ..
                        rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
                    local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

                    local commands = {}
                    local file = io.open(commands_file, 'r')
                    if file then
                        for line in file:lines() do
                            table.insert(commands, line)
                        end
                        file:close()
                    end
                    table.insert(commands, 1, script_import)

                    return commands
                end,
            },
        }

        require("dapui").setup({})
    end
}
