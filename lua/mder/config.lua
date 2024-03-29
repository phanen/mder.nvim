local M = {}

local default_opts = {
  ft = { "markdown", "typst" },
  keymap = {
    line = "<c- >",
    codeblock = "<c-e>",
    listdn = "o",
    listup = "O",
    img_link = "<leader>zi",
    raw_link = "<leader>zj",
  },
}

M.check_box = "%[x%]"
M.empty_box = "%[ %]"

M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = opts.ft,
    callback = function()
      local map = function(mode, act) vim.keymap.set(mode, opts.keymap[act], require("mder")[act], { buffer = 0 }) end
      map({ "n", "x" }, "line")
      map({ "x" }, "codeblock")
      map({ "n" }, "listdn")
      map({ "n" }, "listup")
      map({ "n", "x" }, "img_link")
      map({ "n", "x" }, "raw_link")
    end,
  })
end

return M
