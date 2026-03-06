return {
  "saghen/blink.cmp",
  build = "cargo build --release",
  dependencies = { "rafamadriz/friendly-snippets" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
    },
    appearance = {
      -- nerd_font_variant = "normal",
      -- kind_icons = require("icons").symbol_kinds,
    },
    completion = {
      list = {
        selection = { preselect = true, auto_insert = true },
      },
      documentation = { auto_show = true },
      menu = {
        scrollbar = false,
        draw = {
          gap = 2,
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
          },
        },
      },
    },
    sources = {
      default = function()
        local sources = { "lsp", "buffer" }
        local ok, node = pcall(vim.treesitter.get_node)

        if ok and node then
          if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            table.insert(sources, "path")
          end
          if node:type() ~= "string" then
            table.insert(sources, "snippets")
          end
        end

        return sources
      end,
      per_filetype = {
        codecompanion = { "codecompanion", "buffer" },
      },
    },
    fuzzy = { implementation = "prefer_rust" },
  },
  -- opts_extend = { "sources.default" },
}
