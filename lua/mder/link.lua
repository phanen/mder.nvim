local M = {}

-- wrap url, then paste it
local paste = function(wrap_cb, url)
  if not url then
    local text = vim.fn.getreg "+"
    if text == nil then return end
    -- TODO: whatever, treat it as url now
    url = text:gsub("\n", "")
  end
  url = wrap_cb(url)
  vim.api.nvim_paste(url, true, 1)
end

-- return line with wrapped url, or nil if no url in line
-- TODO: also skip if wrapped url exist
-- TODO: two or more url
local wrap_line = function(cb, line)
  -- https://github.com/sportshead/gx.nvim/blob/77241c1508883882c027aa971b98cd0631ff2a10/lua/gx/helper.lua?plain=1#L49-L60
  local url_patterns = {
    "(https?://[a-zA-Z%d_/%%%-%.~@\\+#=?&:]+)",
    "([a-zA-Z%d_/%-%.~@\\+#]+%.[a-zA-Z%d_/%%%-%.~@\\+#=?&:]+)",
  }
  local s, e
  for _, p in ipairs(url_patterns) do
    s, e = line:find(p)
    if s then break end
  end
  if not s then return nil end
  local url = line:sub(s, e) -- NOTE: may not contain 'https?://'
  url = cb(url)
  line = line:sub(1, s - 1) .. url .. line:sub(e + 1)
  return line
end

-- normal mode only
local wrap_or_paste = function(cb)
  local line = vim.api.nvim_get_current_line()
  local wrapped = wrap_line(cb, line)
  if not wrapped then return paste(cb) end
  vim.api.nvim_set_current_line(wrapped)
end

local wrap_lines = function(cb)
  -- normal: wrap or paste
  local mode = vim.api.nvim_get_mode().mode
  if mode == "n" then return wrap_or_paste(cb) end
  -- visual: linewise wrap
  local vs, ve = require("mder.utils").visual_region()
  local lines = vim.api.nvim_buf_get_lines(0, vs, ve, false)
  lines = vim.tbl_map(function(line) return wrap_line(cb, line) or line end, lines)
  vim.api.nvim_buf_set_lines(0, vs, ve, false, lines)
end

-- wrap with pos inicator...
local img_cb = function(url, prefix, name)
  prefix = prefix or "img:"
  name = name or ""
  return ("![%s%s](%s)"):format(prefix, name, url), #prefix + 3, #prefix + #name + 5
end

local raw_cb = function(url) return "<" .. url .. ">", 2 end

local link_cb = function(url, prefix, name)
  prefix = prefix or "img:"
  name = name or ""
  return ("[%s%s](%s)"):format(prefix, name, url), #prefix + 2, #prefix + #name + 4
end

M.wrap_or_paste_img = function() wrap_lines(img_cb) end
M.wrap_or_paste_raw = function() wrap_lines(raw_cb) end
M.wrap_or_paste_link = function() wrap_lines(link_cb) end

return M
