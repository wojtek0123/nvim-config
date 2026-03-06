local function git_info()
  local head = vim.b.gitsigns_head
  if not head then
    return ""
  end
  local status = vim.b.gitsigns_status or ""
  if status ~= "" then
    return " " .. head .. "  " .. status
  end
  return " " .. head
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

local function filename()
  local path = vim.fn.expand("%:p"):gsub(vim.fn.expand("$HOME"), "~")
  if path == "" then
    path = "[No Name]"
  end
  local flags = ""
  if vim.bo.modified then
    flags = flags .. " *"
  end
  if vim.bo.readonly or not vim.bo.modifiable then
    flags = flags .. " "
  end

  -- return "(" .. buf_count() .. ") " .. path .. flags
  return path .. flags
end

local function diagnostics()
  local d = vim.diagnostic
  local counts = {}
  local e = #d.get(0, { severity = d.severity.ERROR })
  local w = #d.get(0, { severity = d.severity.WARN })
  if e > 0 then
    table.insert(counts, " " .. e)
  end
  if w > 0 then
    table.insert(counts, " " .. w)
  end
  return table.concat(counts, " ")
end

local function filetype()
  local ft = vim.bo.filetype
  if ft == "" then
    return ""
  end
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local icon = devicons.get_icon_by_filetype(ft, { default = false })
    if icon then
      return icon .. " " .. ft
    end
  end
  return ft
end

_G.Statusline = {}

function _G.Statusline.render()
  local left = {}
  local right = {}

  local git = git_info()
  if git ~= "" then
    table.insert(left, git)
  end
  table.insert(left, filename())

  local diag = diagnostics()
  if diag ~= "" then
    table.insert(right, diag)
  end

  local ft = filetype()
  if ft ~= "" then
    table.insert(right, ft)
  end

  table.insert(right, string.format("%2d:%-2d", vim.fn.line("."), vim.fn.virtcol(".")))

  return " " .. table.concat(left, "  ") .. "%=" .. table.concat(right, "  ") .. " "
end

vim.opt.statusline = "%{%v:lua.Statusline.render()%}"
