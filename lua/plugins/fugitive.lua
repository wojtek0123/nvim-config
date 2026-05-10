vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  desc = "Load fugitive for git commits",
  callback = function()
    vim.cmd("packadd vim-fugitive")
  end,
})
