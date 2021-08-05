core.plugins = {
    completion = require("completion"),
    statusline = require("statusline"),
    telescopes = require("telescopes"),
    tsconfig = require("tsconfig"),
}

local plugins = core.plugins

function plugins:load_packer()
    if not self.packer then
        vim.api.nvim_command("packadd packer.nvim")
        self.packer = require("packer")

        self.packer.init(
            {
                package_root = self.package_root,
                compile_path = self.compile_path,
                git = {clone_timeout = 600}
            }
        )

        self.packer.reset()

        self.packer.startup(
            function()
                use {"wbthomason/packer.nvim", opt = true}

                -- colorscheme and semantic highlight
                use {
                    "glepnir/galaxyline.nvim",
                    branch = "main",
                    config = self.statusline.setup,
                    requires = {"kyazdani42/nvim-web-devicons"}
                }
                use {
                    "nvim-treesitter/nvim-treesitter",
                    config = self.tsconfig.setup,
                    requires = {"p00f/nvim-ts-rainbow"}
                }

                -- enhanced text edit
                use {"editorconfig/editorconfig-vim"}
                use {"sheerun/vim-polyglot"}
                use {"fidian/hexmode", ft = {"bin", "img"}}
                use {"mg979/vim-visual-multi"}

                -- language specific
                use {"rust-lang/rust.vim", ft = {"rust"}}

                -- git related
                use {"airblade/vim-gitgutter"}
                use {"tpope/vim-fugitive"}

                -- lspconfig
                use {
                    "neovim/nvim-lspconfig",
                    ft = {"rust", "c", "cpp", "python"},
                    config = self.completion.lspconfig
                }

                -- completion
                use {
                    "hrsh7th/nvim-compe",
                    config = self.completion.compe,
                    requires = {
                        {
                            "hrsh7th/vim-vsnip",
                            config = function()
                                vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
                            end
                        },
                        {
                            "onsails/lspkind-nvim",
                            config = function()
                                require "lspkind".init()
                            end
                        },
                        {"rafamadriz/friendly-snippets"}
                    }
                }

                -- navigation
                use {
                    "nvim-telescope/telescope.nvim",
                    cmd = "Telescope",
                    config = self.telescopes.setup,
                    requires = {
                        {"nvim-lua/popup.nvim"},
                        {"nvim-lua/plenary.nvim"}
                    }
                }
                use {"kyazdani42/nvim-tree.lua"}

                -- utility
                use {"voldikss/vim-floaterm", cmd = "FloatermNew"}
            end
        )
    end
end

function plugins:sync()
    self:load_packer()
    self.packer.sync()
end

function plugins:init()
    local config_path = vim.fn.stdpath("config")

    self.install_path = config_path .. "/pack/packer/opt/packer.nvim"
    self.package_root = config_path .. "/pack"
    self.compile_path = config_path .. "/plugin/packer_compiled.vim"

    if not vim.loop.fs_stat(self.install_path) then
        vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. self.install_path)
        self:sync()
    else
        self:load_packer()
    end
end

return plugins
