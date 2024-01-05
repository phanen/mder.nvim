[![CI](https://github.com/phanen/toggle-checkbox.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/phanen/toggle-checkbox.nvim/actions/workflows/ci.yml)
# toggle-checkbox.nvim

A Neovim plugin for checking and unchecking Markdown checkboxes, written in Lua.

Inspired by [jkramer/vim-checkbox](https://github.com/jkramer/vim-checkbox).


## install

use `lazy.nvim`
```lua
{
  "phanen/toggle-checkbox.nvim",
  ft = "markdown",
  keys = { { mode = { "n", "x" }, "<c-space>", "<cmd>lua require('toggle-checkbox').toggle()<cr>" }, },
  opts = {},
},
```
