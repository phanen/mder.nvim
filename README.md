[![CI](https://github.com/phanen/mder.nvim/actions/workflows/ci.yml/badge.svg)](https://github.com/phanen/mder.nvim/actions/workflows/ci.yml)
# mder.nvim

## Install
```lua
{ "phanen/mder.nvim", ft = "markdown", config = true },
```

## Config
see `config.lua`
```lua
local default_opts = {
  ft = { "markdown", "typst" },
  line = "<c- >",
  codeblock = "<c-e>",
  listdn = "o",
  listup = "O",
  img_link = "<leader>zi",
  raw_link = "<leader>zj",
}
```

## API
see `commands.lua`
