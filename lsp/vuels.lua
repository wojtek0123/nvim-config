-- local mason_path = vim.fn.stdpath("data") .. "/mason"
-- local vue_ls_path = mason_path .. "/packages/vue-language-server/node_modules/@vue/language-server"
--
-- return {
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--     "vue",
--   },
--   root_markers = { "package.json" },
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin",
--         location = vue_ls_path,
--         languages = { "vue" },
--       },
--     },
--   },
-- }

-- If you are using mason.nvim, you can get the ts_plugin_path like this
-- For Mason v1,
-- local mason_registry = require('mason-registry')
-- local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
-- For Mason v2,
-- local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
-- or even
local vue_language_server_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
-- local vue_language_server_path = "/path/to/@vue/language-server"
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
local vtsls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
local vue_ls_config = {
  on_init = function(client)
    client.handlers["tsserver/request"] = function(_, result, context)
      local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
      if #clients == 0 then
        vim.notify("Could not found `vtsls` lsp client, vue_lsp would not work without it.", vim.log.levels.ERROR)
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        command = "typescript.tsserverRequest",
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r.body } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify("tsserver/response", response_data)
      end)
    end
  end,
}
-- nvim 0.11 or above
vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
-- vim.lsp.enable({ "vtsls", "vue_ls" })

-- nvim below 0.11
-- local lspconfig = require('lspconfig')
-- lspconfig.vtsls.setup vtsls_config
-- lspconfig.vue_ls.setup vue_ls_config
