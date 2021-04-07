local fn = vim.fn
local cmd = vim.cmd

-- Auto download packer.nvim
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    local install_path = fn.stdpath("config") .. "/pack/packer/opt/packer.nvim"
    cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

cmd("packadd packer.nvim")
-- Auto compile when there are changes in plugins.lua
cmd("autocmd BufWritePost plugins.lua PackerCompile")

local packer = require("packer")
local util = require("packer.util")
packer.init(
    {
        package_root = util.join_paths(fn.stdpath("config"), "pack"),
        compile_path = util.join_paths(fn.stdpath("config"), "pack", "packer_compiled.vim")
    }
)

packer.startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}

        -- colorscheme and semantic highlight
        use {"zanglg/nova.vim"}
        use {"sheerun/vim-polyglot"}
        use {"glepnir/galaxyline.nvim"}
        use {"kyazdani42/nvim-web-devicons"}

        -- enhanced text edit
        use {"editorconfig/editorconfig-vim"}
        use {"fidian/hexmode"}

        -- language specific
        use {"rust-lang/rust.vim", ft = {"rust"}}

        -- git related
        use {"airblade/vim-gitgutter"}
        use {"tpope/vim-fugitive"}

        -- completion
        use {"neovim/nvim-lspconfig"}
        use {"hrsh7th/nvim-compe"}
        use {"onsails/lspkind-nvim"}
        use {"hrsh7th/vim-vsnip"}
        use {"rafamadriz/friendly-snippets"}

        -- navigation
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"}
            }
        }

        -- utility
        use {"voldikss/vim-floaterm"}
    end
)

-- auto download plugins when first download packer.nvim
if not packer_exists then
    cmd("PackerSync")
end
