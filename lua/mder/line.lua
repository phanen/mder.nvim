local M = {}

local checkbox = "%[x%]"
local emptybox = "%[ %]"

local contain_box = function(line, box) return line:match("^%s*[%-%+%*%=]%s" .. box) end
local make_box = function(line) return (line:gsub("^(%s*[%-%+%*%=]%s)(.*)", "%1[ ] %2", 1)) end
local make_item = function(line) return (line:gsub("^(%s*)(%S*.*)$", "%1* %2")) end

M.toggle_line = function(line)
  -- not contain `xx`, `**xx`
  if not line:match "^%s*[%-%+%*%=]%s*.*" or line:match "^%s*[%-%+%*%=]%S+.*" then return make_item(line) end
  if contain_box(line, checkbox) then return (line:gsub(checkbox, emptybox, 1)) end
  if contain_box(line, emptybox) then return (line:gsub(emptybox, checkbox, 1)) end
  return make_box(line)
end

M.toggle_lines = function()
  local vs, ve = require("mder.utils").visual_region()
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  lines = vim.iter(lines):map(function(line) return M.toggle_line(line) end):totable()
  vim.api.nvim_buf_set_lines(0, vs, ve, false, lines)
end

return M
