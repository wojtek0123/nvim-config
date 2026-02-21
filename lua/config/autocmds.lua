vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })

      vim.keymap.set("n", "<Tab>", "<CR>", { remap = true, buffer = true })
      vim.keymap.set("n", "cp", ":pclose<CR>", { desc = "Close netrw preview" })
    end

    -- <Tab> to open a file or enter a directory
    bind("<Tab>", "<CR>")

    -- <Shift-Tab> to go up to the parent directory
    bind("<S-Tab>", "-")
  end,
})
