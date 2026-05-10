require("conform").setup({
  formatters = {
    -- Override the prettier formatter configuration
    prettier = {
      -- This ensures that any local config file found will be used
      -- over any other options passed via CLI arguments.
      prepend_args = { "--config-precedence", "prefer-file" },
    },
  },
  formatters_by_ft = {
    lua = { "stylua" },
    html = { "prettier", "prettierd" },
    htmlangular = { "prettier", "prettierd" },
    typescript = { "prettier", "prettierd" },
    javascript = { "prettier", "prettierd" },
    typescriptreact = { "prettier", "prettierd" },
    javascriptreact = { "prettier", "prettierd" },
    css = { "prettier", "prettierd" },
    scss = { "prettier", "prettierd" },
    astro = { "prettier", "prettierd" },
    svg = { "prettier", "prettierd" },
    json = { "prettier", "prettierd" },
  },
  notify_on_error = false,
  format_on_save = {
    lsp_fallback = true,
    async = false,
  },
})
