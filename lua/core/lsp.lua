vim.lsp.config["angularls"] = {
  cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    "../..,?/node_modules",
    "--ngProbeLocations",
    "../../@angular/language-server/node_modules,?/node_modules/@angular/language-server/node_modules",
    "--angularCoreVersion",
    "",
  },
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_markers = { "angular.json", "nx.json" },
}

vim.lsp.config["vtsls"] = {
  cmd = { "vtsls --stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "package.json", "tsconfig.json" },
}

vim.lsp.enable({
  "gopls",
  "lua_ls",
  "vtsls",
  "html",
  "css",
  "angularls",
  "tailwindcss",
  "vuels",
})

vim.diagnostic.config({
  virtual_lines = true,
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
