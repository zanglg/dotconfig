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
