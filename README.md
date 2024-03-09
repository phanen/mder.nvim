[![CI](https://github.com/phanen/mder.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/phanen/mder.nvim/actions/workflows/ci.yml)
# mder.nvim

## Install
```lua
{ "phanen/mder.nvim", ft = "markdown", config = true },
```

## Config
```lua
{
  ft = { "markdown", "typst" },
  line = "<c- >",
  codeblock = "<c-e>",
  listdn = "o",
  listup = "O",
},
```

## API
```lua
vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "markdown" },
  callback = function()
    vim.keymap.set({ "x", "n" }, "<c- >", require("mder").line, { buffer = 0 })
    vim.keymap.set({ "x" }, "<c-e>", require("mder").codeblock, { buffer = 0 })
    vim.keymap.set({ "n" }, "o", require("mder").listdn, { expr = true, buffer = 0 })
    vim.keymap.set({ "n" }, "O", require("mder").listup, { expr = true, buffer = 0 })
  end,
})
```
