-- 0-index, exclusive, linewise
-- also "correct" in normal mode
local visual_region = function()
  local vs, ve = vim.fn.line ".", vim.fn.line "v"
  if vs > ve then
    vs, ve = ve, vs
  end
  return vs - 1, ve
end

return {
  visual_region = visual_region,
}
