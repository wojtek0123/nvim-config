local function get_git_info()
  local dict = vim.b.gitsigns_status_dict

  if not dict then
    return ""
  end

  local result = " " .. dict.head
  local changes = {}

  if dict.added and dict.added > 0 then
    table.insert(changes, "+" .. dict.added)
  end

  if dict.changed and dict.changed > 0 then
    table.insert(changes, "~" .. dict.changed)
  end

  if dict.removed and dict.removed > 0 then
    table.insert(changes, "-" .. dict.removed)
  end

  if #changes > 0 then
    result = result .. " " .. table.concat(changes, " ")
  end

  return result
end

-- local function buf_count()
--   local count = 0
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
--       count = count + 1
--     end
--   end
--   return count
-- end

_G.statusline_show_path = false

vim.keymap.set("n", "<leader>sp", function()
  _G.statusline_show_path = not _G.statusline_show_path
  vim.cmd("redrawstatus")
end, { desc = "Toggle full path in statusline" })

local function get_filename()
  local full = vim.fn.expand("%:p"):gsub(vim.fn.expand("$HOME"), "~")

  local path
  if full == "" then
    path = "[No Name]"
  elseif _G.statusline_show_path then
    -- local filename = vim.fn.fnamemodify(full, ":t")
    -- local dir = vim.fn.fnamemodify(full, ":h")
    -- local short_dir = dir:gsub("([^/])[^/]*/", "%1/"):gsub("([^/])[^/]*$", "%1")
    path = full
  else
    path = vim.fn.fnamemodify(full, ":t")
  end

  local flags = ""

  if vim.bo.modified then
    flags = flags .. "*"
  end

  if vim.bo.readonly or not vim.bo.modifiable then
    flags = flags .. " "
  end

  -- return "(" .. buf_count() .. ") " .. path .. flags
  return path .. flags
end

-- local function diagnostics()
--   local d = vim.diagnostic
--   local counts = {}
--   local e = #d.get(0, { severity = d.severity.ERROR })
--   local w = #d.get(0, { severity = d.severity.WARN })
--   if e > 0 then
--     table.insert(counts, " " .. e)
--   end
--   if w > 0 then
--     table.insert(counts, " " .. w)
--   end
--   return table.concat(counts, " ")
-- end

local function get_filetype()
  local filetype = vim.bo.filetype

  if filetype == "" then
    return ""
  end

  local ok, devicons = pcall(require, "nvim-web-devicons")

  if ok then
    local icon = devicons.get_icon_by_filetype(filetype, { default = false })
    if icon then
      return icon .. " " .. filetype
    end
  end

  return filetype
end

local function get_lsp_info()
  local clients = vim.lsp.get_clients({ bufnr = 0 })

  if #clients == 0 then
    return ""
  end

  local languages = vim.tbl_map(function()
    return "+"
  end, clients)

  return "󰰎 " .. table.concat(languages, "")
end

_G.Statusline = {}

function _G.Statusline.render()
  local left = {}
  local right = {}

  local git = get_git_info()
  if git ~= "" then
    table.insert(left, git)
  end
  table.insert(left, get_filename())

  -- local diag = diagnostics()
  -- if diag ~= "" then
  --   table.insert(right, diag)
  -- end

  local lsp = get_lsp_info()
  if lsp ~= "" then
    table.insert(right, lsp)
  end

  local filetype = get_filetype()

  if filetype ~= "" then
    table.insert(right, filetype)
  end

  table.insert(right, string.format("%2d:%-2d", vim.fn.line("."), vim.fn.virtcol(".")))

  return " " .. table.concat(left, "  ") .. "%=" .. table.concat(right, "  ") .. " "
end

vim.opt.statusline = "%{%v:lua.Statusline.render()%}"
vim.opt.laststatus = 3
