require("fzf-lua").setup({
  -- "default",
  winopts = {
    fullscreen = true,
    preview = {
      hidden = true,
    },
  },
  keymap = {
    builtin = {
      ["ctrl-/"] = "toggle-preview",
    },
  },
})

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect Fzf-lua" })
vim.keymap.set({ "n", "v" }, "<leader>sw", function()
  if vim.fn.mode() == "v" then
    fzf.grep_visual()
  else
    fzf.grep_cword()
  end
end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sc", fzf.commands, { desc = "[S]earch [C]ommands" })

vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader><leader>", function()
  fzf.buffers({ sort_mru = true, sort_lastused = true })
end, { desc = "[ ] Open fzf-lua buffers" })

vim.keymap.set("n", "<leader>/", function()
  fzf.blines({ winopts = { preview = { hidden = false } } })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>s/", function()
  fzf.lgrep_curbuf()
end, { desc = "[S]earch [/] in Open Files" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("fzf-lua-lsp-attach", { clear = true }),
  callback = function(event)
    local buf = event.buf
    vim.keymap.set("n", "grr", fzf.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })
    vim.keymap.set("n", "gri", fzf.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })
    vim.keymap.set("n", "grd", fzf.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })
    vim.keymap.set("n", "gO", fzf.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })
    vim.keymap.set("n", "gW", fzf.lsp_live_workspace_symbols, { buffer = buf, desc = "Open Workspace Symbols" })
    vim.keymap.set("n", "grt", fzf.lsp_typedefs, { buffer = buf, desc = "[G]oto [T]ype Definition" })
  end,
})

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
  fzf.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
