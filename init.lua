require("core.pack")
require("core.statusline")
require("core.diagnostics")

require("vim._core.ui2").enable({})

require("config.options")
require("config.keymaps")
require("config.autocmds")

require("plugins.lsp")
require("plugins.fzf-lua")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.gitsigns")
require("plugins.blink")

vim.cmd.colorscheme("kanagawa")
