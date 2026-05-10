---@param repo string
---@return string
local function gh(repo)
  return "https://github.com/" .. repo
end

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ""
    local stdout = result.stdout or ""
    local output = stderr ~= "" and stderr or stdout
    if output == "" then
      output = "No output from build command."
    end
    vim.notify(("Build failed for %s:\n%s"):format(name, output), vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
      run_build(name, { "make" }, ev.data.path)
      return
    end

    if name == "LuaSnip" then
      if vim.fn.has("win32") ~= 1 and vim.fn.executable("make") == 1 then
        run_build(name, { "make", "install_jsregexp" }, ev.data.path)
      end
      return
    end

    if name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
      return
    end
  end,
})

vim.pack.add({
  gh("windwp/nvim-autopairs"),
  gh("rebelot/kanagawa.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("stevearc/conform.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("lukas-reineke/indent-blankline.nvim"),
  gh("kdheepak/lazygit.nvim"),
  gh("mfussenegger/nvim-lint"),
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("mason-org/mason-lspconfig.nvim"),
  gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  gh("windwp/nvim-ts-autotag"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = gh("tpope/vim-fugitive"), type = "opt" },
  gh("NMAC427/guess-indent.nvim"),
  gh("folke/which-key.nvim"),
  gh("mikavilpas/yazi.nvim"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
  gh("stevearc/oil.nvim"),

  -- telescope_plugins,
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-telescope/telescope.nvim"),
  gh("nvim-telescope/telescope-ui-select.nvim"),
})

if vim.fn.executable("make") == 1 then
  gh("nvim-telescope/telescope-fzf-native.nvim")
end

require("guess-indent").setup({})
require("nvim-autopairs").setup({})
require("oil").setup({
  view_options = { show_hidden = true },
  keymaps = {
    ["<Tab>"] = "actions.select",
    ["<S-Tab>"] = "actions.parent",
  },
})

vim.keymap.set("n", "<leader>e", ":Oil<cr>", { desc = "Open parent directory" })
