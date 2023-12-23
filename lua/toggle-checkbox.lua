local CHECK_BOX = "%[x%]"
local EMPTY_BOX = "%[ %]"

local toggle_line = function(line)
	local has = function(sym) return line:find("^%s*- " .. sym) or line:find("^%s*%d%. " .. sym) end
	local check = function() return line:gsub(EMPTY_BOX, CHECK_BOX, 1) end
	local clear = function() return line:gsub(CHECK_BOX, EMPTY_BOX, 1) end
	local make_box = function()
		if line:match("^%s*-%s.*$") then return line:gsub("(%s*- )(.*)", "%1[ ] %2", 1) end
		if line:match("^%s*%d%s.*$") then return line:gsub("(%s*%d%. )(.*)", "%1[ ] %2", 1) end
		return line:gsub("(%S+)", "- [ ] %1", 1)
	end
	if has(CHECK_BOX) then return clear() end
	if has(EMPTY_BOX) then return check() end
	return make_box()
end

local M = {}
M.toggle = function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local lineid = cursor[1] - 1
	local line = vim.api.nvim_buf_get_lines(0, lineid, lineid + 1, false)[1] or ""
	local new_line = toggle_line(line)
	vim.api.nvim_buf_set_lines(0, lineid, lineid + 1, false, { new_line })
	vim.api.nvim_win_set_cursor(0, cursor)
end

vim.api.nvim_create_user_command("ToggleCheckbox", M.toggle, {})
return M
