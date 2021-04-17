local tsconfig = {}

function tsconfig.setup()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {enable = true},
        rainbow = {enable = true}
    }
end

return tsconfig
