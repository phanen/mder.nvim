local CHECK_BOX = "%[x%]"
local EMPTY_BOX = "%[ %]"
local PREFIX = "-"

local toggle_line = function(line)
  local has = function(box) return line:find("^%s*- " .. box) or line:find("^%s*%d%. " .. box) end
  local check = function() return line:gsub(EMPTY_BOX, CHECK_BOX, 1) end
  local clear = function() return line:gsub(CHECK_BOX, EMPTY_BOX, 1) end
  local make_box = function()
    if line:match("^%s*-%s.*$") then return line:gsub("(%s*- )(.*)", "%1[ ] %2", 1) end
    if line:match("^%s*%d%s.*$") then return line:gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1) end
    return line:gsub("(%S+)", PREFIX .. " %1", 1)
  end
  if has(CHECK_BOX) then return clear() end
  if has(EMPTY_BOX) then return check() end
  return make_box()
end

local M = {}

M.toggle = function()
  local vstart, vend = vim.fn.getpos('.')[2], vim.fn.getpos('v')[2]
  if vstart > vend then vstart, vend = vend, vstart end
  vstart = vstart - 1
  local lines = vim.api.nvim_buf_get_lines(0, vstart, vend, false)
  for i, line in ipairs(lines) do
    lines[i] = toggle_line(line)
  end
  vim.api.nvim_buf_set_lines(0, vstart, vend, false, lines)
end

M.setup = function(opts)
  if opts.check_sym then CHECK_BOX = "%[" .. opts.check_sym .. "%]" end
  if opts.prefix then PREFIX = opts.prefix end
  if opts.prefix_with_box then PREFIX = PREFIX .. " [ ]" end
end

return M
