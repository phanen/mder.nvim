local getvpos = require("mder.utils").getvpos

local check = "%[x%]"
local empty = "%[ %]"

local items = { "%-", "%+", "%*", "%=", "%d+%." }

local contain_item = function(line)
  return vim.iter(items):any(function(i) return line:find("^%s*" .. i) end)
end

local contain_box = function(line, box)
  return vim.iter(items):any(function(i) return line:find("^%s*" .. i .. " " .. box) end)
end

local make_box = function(line)
  for _, i in ipairs(items) do
    local new_line, ok = line:gsub("^(%s*" .. i .. "%s)(.*)", "%1[ ] %2", 1)
    if ok == 1 then return new_line end
  end
  return line
end

local make_item = function(line)
  local new_line, _ = line:gsub("^(%s*)(%S*.*)$", "%1* %2")
  return new_line
end

local toggle_line = function(line)
  if not contain_item(line) then return make_item(line) end
  if contain_box(line, check) then
    local new_line, _ = line:gsub(check, empty, 1)
    return new_line
  end
  if contain_box(line, empty) then
    local new_line, _ = line:gsub(empty, check, 1)
    return new_line
  end
  return make_box(line)
end

local line = function()
  local vs, ve = getvpos()
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  vim.api.nvim_buf_set_lines(0, vs, ve, false, vim.iter(lines):map(toggle_line):totable())
end

return {
  line = line,
  toggle_line = toggle_line,
}
