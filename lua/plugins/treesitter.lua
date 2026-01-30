return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "regex",
      "vim",
      "vimdoc",
      "yaml",
      "angular",
      "typescript",
    }

    local ts = require("nvim-treesitter")
    for _, parser in ipairs(ensure_installed) do
      ts.install(parser)
    end

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local ok, _ = pcall(vim.treesitter.start, args.buf)

        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
      end,
    })
  end,
}
