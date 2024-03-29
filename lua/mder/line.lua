local config = require "mder.config"
local checkbox = config.check_box
local emptybox = config.empty_box

local contain_item = function(line) return line:find "^%s*[%-%+%*%=]" end

local contain_box = function(line, box) return line:find("^%s*[%-%+%*%=]%s" .. box) end

local make_box = function(line) return (line:gsub("^(%s*[%-%+%*%=]%s)(.*)", "%1[ ] %2", 1)) end

local make_item = function(line) return (line:gsub("^(%s*)(%S*.*)$", "%1* %2")) end

local toggle_line = function(line)
  if not contain_item(line) then return make_item(line) end
  if contain_box(line, checkbox) then return (line:gsub(checkbox, emptybox, 1)) end
  if contain_box(line, emptybox) then return (line:gsub(emptybox, checkbox, 1)) end
  return make_box(line)
end

local toggle_lines = function()
  local vs, ve = require("mder.utils").visual_region()
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  vim.api.nvim_buf_set_lines(0, vs, ve, false, vim.iter(lines):map(toggle_line):totable())
end

return {
  toggle_lines = toggle_lines,
  toggle_line = toggle_line,
}
