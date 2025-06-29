return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- keymaps = {
    --   ["h"] = "actions.parent", -- Go to parent directory
    --   ["l"] = "actions.select", -- Open the selected file or directory
    --   ["<CR>"] = false, -- Disable Enter if you don't want it to do anything
    -- },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
