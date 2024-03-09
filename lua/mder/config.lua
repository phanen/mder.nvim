local default_opts = {
  ft = { "markdown", "typst" },
  line = "<c- >",
  codeblock = "<c-e>",
  listdn = "o",
  listup = "O",
}

return {
  setup = function(opts)
    opts = vim.tbl_deep_extend("force", default_opts, opts or {})
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = opts.ft,
      callback = function()
        vim.keymap.set({ "x", "n" }, opts.line, require("mder").line, { buffer = 0 })
        vim.keymap.set({ "x" }, opts.codeblock, require("mder").codeblock, { buffer = 0 })
        vim.keymap.set({ "n" }, opts.listdn, require("mder").listdn, { expr = true, buffer = 0 })
        vim.keymap.set({ "n" }, opts.listup, require("mder").listup, { expr = true, buffer = 0 })
      end,
    })
  end,
}
