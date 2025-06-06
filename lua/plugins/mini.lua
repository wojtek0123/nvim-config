return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require("mini.surround").setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = true })

    local function get_winbar_path()
      local full_path = vim.fn.expand("%:p")
      return full_path:gsub(vim.fn.expand("$HOME"), "~")
    end
    -- Function to get the number of open buffers using the :ls command
    local function get_buffer_count()
      local buffers = vim.fn.execute("ls")
      local count = 0
      -- Match only lines that represent buffers, typically starting with a number followed by a space
      for line in string.gmatch(buffers, "[^\r\n]+") do
        if string.match(line, "^%s*%d+") then
          count = count + 1
        end
      end
      return count
    end
    -- Function to update the winbar
    local function update_winbar()
      local home_replaced = get_winbar_path()
      local buffer_count = get_buffer_count()

      local path = "%#WinBar2#(" .. buffer_count .. ") " .. "%#WinBar1#" .. home_replaced .. "%*%=%#WinBar2#"

      -- Override the section_filename function to disable file path
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_filename = function()
        return path
      end
    end
    -- Autocmd to update the winbar on BufEnter and WinEnter events
    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
      callback = update_winbar,
    })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
