local mason_path = vim.fn.stdpath("data") .. "/mason"
local vue_ls_path = mason_path .. "/packages/vue-language-server/node_modules/@vue/language-server"

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  root_markers = { "package.json" },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_ls_path,
        languages = { "vue" },
      },
    },
  },
}
