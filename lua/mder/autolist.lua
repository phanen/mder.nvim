local M = {}

-- auto list item
local autolist = function(c)
  return function()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
    for it, p in pairs {
      ["-"] = "%-",
      ["+"] = "%+",
      ["*"] = "%*",
      ["="] = "%=",
    } do
      -- if line:find("^%s*" .. p .. " %[x%]") then
      --   vim.api.nvim_feedkeys(c .. it .. " [x] ", "n", false)
      --   return
      -- end
      -- if line:find("^%s*" .. p .. " %[ %]") then
      --   vim.api.nvim_feedkeys(c .. it .. " [ ] ", "n", false)
      --   return
      -- end
      if line:find("^%s*" .. p .. " ") then
        vim.api.nvim_feedkeys(c .. it .. " ", "n", false)
        return
      end
    end
    vim.api.nvim_feedkeys(c, "n", false)
  end
end

M.listup = autolist "O"
M.listdn = autolist "o"

return M
