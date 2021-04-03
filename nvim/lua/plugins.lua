
local fn  = vim.fn
local cmd = vim.cmd

-- Auto download packer.nvim
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
    local install_path = fn.stdpath('config').."/pack/packer/opt/packer.nvim"
    cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

cmd('packadd packer.nvim')
-- Auto compile when there are changes in plugins.lua
cmd('autocmd BufWritePost plugins.lua PackerCompile')

local packer = require('packer')
local util   = require('packer.util')
packer.init({
    package_root = util.join_paths(fn.stdpath('config'), 'pack'),
    compile_path = util.join_paths(fn.stdpath('config'), 'pack', 'packer_compiled.vim')
})

packer.startup(function()
    use {'wbthomason/packer.nvim', opt = true}

-- colorscheme and semantic highlight
    use {'zanglg/nova.vim'}
    use {'sheerun/vim-polyglot'}
    use {'glepnir/galaxyline.nvim',
        branch = 'main',
        config = function() require('statusline') end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

-- enhanced text edit
    use {'editorconfig/editorconfig-vim'}
    use {'junegunn/vim-easy-align'}
    use {'terryma/vim-multiple-cursors'}
    use {'rust-lang/rust.vim', ft = {'rust'}}
    use {'sbdchd/neoformat'}
    use {'fidian/hexmode'}
    use {'jiangmiao/auto-pairs'}

-- git related
    use {'airblade/vim-gitgutter'}
    use {'tpope/vim-fugitive'}

-- completion
    use {'hrsh7th/nvim-compe',
        config = function() require('completion') end,
        requires = {
            {'neovim/nvim-lspconfig'},
            {"rafamadriz/friendly-snippets"},
            {'hrsh7th/vim-vsnip'},
        }
    }

-- utility
    use {'voldikss/vim-floaterm'}

end)
 
-- auto download plugins when first download packer.nvim
if not packer_exists then cmd('PackerSync') end
