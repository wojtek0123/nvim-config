vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 999999999
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↳"
vim.o.confirm = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.g.lazygit_floating_window_scaling_factor = 1.0

-- netrw
vim.g.netrw_banner = 0
-- Overrides default netrw buffer settings to add numbers (nu) and relative numbers (rnu)
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"
-- vim.g.netrw_browse_split = 1
vim.g.netrw_keepdir = 0
vim.g.netrw_clipboard = 0
vim.g.netrw_preview = 1
vim.opt.splitright = true
vim.g.netrw_altv = 1
-- vim.g.netrw_liststyle = 0
