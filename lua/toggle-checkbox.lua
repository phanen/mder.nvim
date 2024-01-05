local C = "%[x%]"
local E = "%[ %]"

local item_pattern = {
  ["-"] = "%-",
  ["+"] = "%+",
  ["*"] = "%*",
  ["="] = "%=",
}

local M = {}

M.toggle_line = function(line)
  local has = function(box) return line:find("^%s*%- " .. box) or line:find("^%s*%d%. " .. box) end
  local check = function() return line:gsub(E, C, 1) end
  local clear = function() return line:gsub(C, E, 1) end
  local make_box = function()
    for _, pat in pairs(item_pattern) do
      if line:match("^%s*" .. pat .. "%s.*$") then return line:gsub("(%s*" .. pat .. " )(.*)", "%1[ ] %2", 1) end
    end
    return line:gsub("(%S*)", "* %1", 1)
  end
  if has(C) then return clear() end
  if has(E) then return check() end
  return make_box()
end

M.toggle = function()
  local vstart, vend = vim.fn.getpos(".")[2], vim.fn.getpos("v")[2]
  if vstart > vend then
    vstart, vend = vend, vstart
  end
  vstart = vstart - 1
  local lines = vim.api.nvim_buf_get_lines(0, vstart, vend, false)
  for i, line in ipairs(lines) do
    lines[i] = M.toggle_line(line)
  end
  vim.api.nvim_buf_set_lines(0, vstart, vend, false, lines)
end

M.setup = function(opts)
  if opts.checkbox_sym then C = "%[" .. opts.checkbox_sym .. "%]" end
end

return M
