return {
  cmd = {
    "ngserver",
    "--stdio",
    "--tsProbeLocations",
    vim.fn.fnamemodify(vim.fn.getcwd(), ":p") .. "node_modules",
    "--ngProbeLocations",
    vim.fn.fnamemodify(vim.fn.getcwd(), ":p") .. "node_modules",
  },
  filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
  root_markers = { "angular.json", "nx.json" },
}
