local k = require("mder.utils").k

-- surround codeblock with correct indent
local wrap_codeblock = function()
  local vs, ve = vim.fn.getpos(".")[2], vim.fn.getpos("v")[2]
  if vs > ve then
    vs, ve = ve, vs
  end
  vs = vs - 1
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  lines = { "```", unpack(lines) }
  lines[#lines + 1] = "```"
  vim.api.nvim_buf_set_lines(0, vs, ve, false, lines)

  vim.api.nvim_feedkeys(k "<esc>", "x", false)
  vim.api.nvim_win_set_cursor(0, { vs + 1, 3 })
  vim.api.nvim_feedkeys(k "A", "n", false)
end

return {
  codeblock = wrap_codeblock,
}
