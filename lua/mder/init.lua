return setmetatable({}, {
  __index = function(_, k) return require("mder.commands")[k] end,
})
