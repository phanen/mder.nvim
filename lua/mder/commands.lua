return {
  codeblock = function() return require("mder.codeblock").wrap_codeblock() end,
  line = function() return require("mder.line").toggle_lines() end,
  listdn = function() return require("mder.autolist").listdn() end,
  listup = function() return require("mder.autolist").listup() end,
  img_link = function() return require("mder.link").wrap_or_paste_img() end,
  raw_link = function() return require("mder.link").wrap_or_paste_raw() end,
}
