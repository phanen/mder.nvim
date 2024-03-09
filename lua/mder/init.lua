local M = {}

M.setup = function(opts) require("mder.config").setup(opts) end

return setmetatable(M, {
  __index = function(_, k) return require("mder.commands")[k] end,
})
