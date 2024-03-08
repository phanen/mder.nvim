[![CI](https://github.com/phanen/toggle-checkbox.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/phanen/toggle-checkbox.nvim/actions/workflows/ci.yml)
# mder.nvim

```lua
{
  "phanen/mder.nvim",
  ft = "markdown",
  config = function()
    au("Filetype", {
      pattern = { "markdown", "typst" },
      callback = function()
        map({ "n", "x" }, "<c- >", require("mder").line, { buffer = 0 })
        map("x", "<c-e>", require("mder").codeblock, { buffer = 0 })
        map("n", "o", require("mder").listdn, { expr = true, buffer = 0 })
        map("n", "O", require("mder").listup, { expr = true, buffer = 0 })
      end,
    })
  end,
},
```
