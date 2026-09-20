local nova_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/../nova.nvim")

if not vim.uv.fs_stat(nova_path) then
    error("nova.nvim submodule is missing; run git submodule update --init")
end

vim.opt.runtimepath:prepend(nova_path)

local modules = {
    "options",
    "packages",
    "plugins",
    "actions",
    "keymaps",
}

for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
        error(("failed to load %s:\n%s"):format(module, err))
    end
end
