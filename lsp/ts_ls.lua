return {
  -- cmd = { "typescript-language-server", "--stdio" },
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
  workspace_required = true, -- Only attach if a workspace is found
}
