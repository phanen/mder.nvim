local toggle_line = require("mder.line").toggle_line
local getvpos = require("mder.utils").getvpos

local line = function()
  local vs, ve = getvpos()
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  vim.api.nvim_buf_set_lines(0, vs, ve, false, vim.iter(lines):map(toggle_line):totable())
end

return {
  line = line,
}
