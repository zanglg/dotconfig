-- set border for vim diagnostic float window
vim.diagnostic.config({
    float = {
        border = require("options").border,
    },
})

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
    })
end
