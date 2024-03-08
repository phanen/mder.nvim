local toggle_line = require("toggle-checkbox.line").toggle_line
local getvpos = require("toggle-checkbox.utils").getvpos

local toggle = function()
  local vs, ve = getvpos()
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  vim.api.nvim_buf_set_lines(0, vs, ve, false, vim.iter(lines):map(toggle_line):totable())
end

return {
  toggle = toggle,
}
