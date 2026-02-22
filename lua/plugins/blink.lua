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
      nerd_font_variant = "normal",
    },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust" },
  },
  opts_extend = { "sources.default" },
}
