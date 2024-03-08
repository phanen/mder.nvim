local getvpos = function()
  local vs, ve = vim.fn.getpos(".")[2], vim.fn.getpos("v")[2]
  if vs > ve then
    vs, ve = ve, vs
  end
  return vs - 1, ve
end

local k = function(str) return vim.api.nvim_replace_termcodes(str, true, true, true) end

return {
  getvpos = getvpos,
  k = k,
}
