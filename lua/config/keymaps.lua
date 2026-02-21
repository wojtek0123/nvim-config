vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Write" })

-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- vim.keymap.set("n", "<leader>e", ":Ex<cr>", { desc = "Open [E]xplorer" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>ee", ":Explore<CR>", { desc = "Toggle Netrw" })
vim.keymap.set("n", "<leader>eh", ":Hexplore<CR>", { desc = "Toggle Horizontal Netrw" })
vim.keymap.set("n", "<leader>ev", ":Vexplore<CR>", { desc = "Toggle Horizontal Netrw" })
vim.keymap.set("n", "<Leader>et", ":Texplore<CR>", { silent = true, desc = "Fullscreen netrw" })
--
-- Map Alt + 1-9 to jump to specific tabs
for i = 1, 9 do
  vim.keymap.set("n", "<C-" .. i .. ">", i .. "gt", { silent = true, desc = "Go to tab " .. i })
end
