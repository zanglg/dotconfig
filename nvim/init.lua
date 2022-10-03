-- general options of neovim
require("options").setup()

-- configs of managered plugins
require("plugins").setup()

-- configs of builtin feature of neovim
require("configs").setup()

-- load custom autocmds
require("autocmds").setup()
