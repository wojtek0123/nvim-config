return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
      typescript = {},
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      gopls = {},
      angularls = {},
      tailwindcss = {},
      html = {},
      cssls = {},
      astro = {},
    }

    local blink = require("blink.cmp")
    local defaults = {
      capabilities = blink.get_lsp_capabilities(),
    }

    for server, config in pairs(servers) do
      local merged_config = vim.tbl_deep_extend("force", defaults, config)

      vim.lsp.config(server, merged_config)
      vim.lsp.enable(server)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
        -- map("<leader>cd", vim.diagnostic.open_float, "[C]ode [D]iagnostics for line")
        -- map("<leader>d", function()
        --   local config = vim.diagnostic.config()
        --   if config.virtual_lines and config.virtual_lines.current_line then
        --     vim.diagnostic.config({ virtual_lines = false })
        --   else
        --     vim.diagnostic.config({ virtual_lines = { current_line = true, format = virtual_lines_format } })
        --   end
        -- end, "Toggle virtual lines diagnostics for current line")
        -- ---@param client vim.lsp.Client
        -- ---@param method vim.lsp.protocol.Method
        -- ---@param bufnr? integer
        -- ---@return boolean
        -- local function client_supports_method(client, method, bufnr)
        --   if vim.fn.has("nvim-0.11") == 1 then
        --     return client:supports_method(method, bufnr)
        --   else
        --     return client.supports_method(method, { bufnr = bufnr })
        --   end
        -- end

        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
        --
        -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        --   map("<leader>th", function()
        --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        --   end, "[T]oggle Inlay [H]ints")
        -- end
      end,
    })
  end,
}
