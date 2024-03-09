[![CI](https://github.com/phanen/toggle-checkbox.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/phanen/toggle-checkbox.nvim/actions/workflows/ci.yml)
# mder.nvim

```lua
{
  "phanen/mder.nvim",
  ft = "markdown",
  config = function()
    au("Filetype", {
      pattern = { "markdown" },
      callback = function()
        vim.keymap.set({ "n", "x" }, "<c- >", require("mder").line, { buffer = 0 })
        vim.keymap.set("x", "<c-e>", require("mder").codeblock, { buffer = 0 })
        vim.keymap.set("n", "o", require("mder").listdn, { expr = true, buffer = 0 })
        vim.keymap.set("n", "O", require("mder").listup, { expr = true, buffer = 0 })
      end,
    })
  end,
},
```
