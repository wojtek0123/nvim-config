return {
  "saghen/blink.cmp",
  -- build = "cargo +nightly build --release",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "enter",
    },
    appearance = {
      -- nerd_font_variant = "normal",
      kind_icons = require("icons").symbol_kinds,
    },
    completion = {
      list = {
        -- Insert items while navigating the completion list.
        selection = { preselect = true, auto_insert = true },
        max_items = 10,
      },
      documentation = { auto_show = true },
      menu = {
        scrollbar = false,
        draw = {
          gap = 2,
          columns = {
            { "kind_icon", "kind", gap = 1 },
            { "label", "label_description", gap = 1 },
          },
        },
      },
    },
    -- completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
    -- sources = {
    --   default = { "lsp", "path", "snippets", "buffer" },
    -- },
    sources = {
      -- Disable some sources in comments and strings.
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
    fuzzy = { implementation = "lua" },
  },
  -- opts_extend = { "sources.default" },
}
