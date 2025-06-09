return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        html = { "prettier" },
        htmlangular = { "prettier" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
      },
    })
  end,
}
