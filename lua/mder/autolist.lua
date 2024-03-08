-- auto list item
local autolist = function(c)
  return function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    for it, pat in pairs {
      ["-"] = "%-",
      ["+"] = "%+",
      ["*"] = "%*",
      ["="] = "%=",
    } do
      if line:find("^%s*" .. pat .. " %[ %]") then return c .. it .. " [ ] " end
      if line:find("^%s*" .. pat .. " ") then return c .. it .. " " end
    end
    return c
  end
end

return {
  listup = autolist "O",
  listdn = autolist "o",
}
