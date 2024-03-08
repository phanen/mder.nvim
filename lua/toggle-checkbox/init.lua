local C = "%[x%]"
local E = "%[ %]"

local M = {}

local items = { "%-", "%+", "%*", "%=", "%d+%." }

local has_box = function(line, box)
  return vim.iter(items):any(function(i) return line:find("^%s*" .. i .. " " .. box) end)
end

local make_box = function(line)
  local ok
  for _, i in ipairs(items) do
    line, ok = line:gsub("^(%s*" .. i .. "%s)(.*)", "%1[ ] %2", 1)
    if ok == 1 then return line end
  end
  return ({ line:gsub("(%S+)", "* %1", 1) })[1]
end

local toggle_line = function(line)
  if line == "" then return "* " end
  if has_box(line, C) then return ({ line:gsub(C, E, 1) })[1] end
  if has_box(line, E) then return ({ line:gsub(E, C, 1) })[1] end
  return make_box(line)
end

M.toggle_line = toggle_line

M.toggle = function()
  local vstart, vend = vim.fn.getpos(".")[2], vim.fn.getpos("v")[2]
  if vstart > vend then
    vstart, vend = vend, vstart
  end
  vstart = vstart - 1
  local lines = vim.api.nvim_buf_get_lines(0, vstart, vend, false)
  vim.api.nvim_buf_set_lines(0, vstart, vend, false, vim.iter(lines):map(toggle_line):totable())
end

M.setup = function(_) end

return M
