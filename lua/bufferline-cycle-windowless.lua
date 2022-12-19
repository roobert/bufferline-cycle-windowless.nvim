local state = require("bufferline.state")
local config = require("bufferline.config")

local M = {}

-- taken from: https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline/commands.lua
--- open the current element
---@param id number
local function open_element(id)
	if config:is_tabline() and vim.api.nvim_tabpage_is_valid(id) then
		vim.api.nvim_set_current_tabpage(id)
	elseif vim.api.nvim_buf_is_valid(id) then
		vim.api.nvim_set_current_buf(id)
	end
end

function M.cycle_hidden(direction)
	local item = M.next_visible_buffer(direction)

	if not item then
		return
	end

	open_element(item.id)
end

function M.next_visible_buffer(direction)
	if vim.opt.showtabline == 0 then
		if direction > 0 then
			vim.cmd("bnext")
		end
		if direction < 0 then
			vim.cmd("bprev")
		end
	end

	local index = require("bufferline.commands").get_current_element_index(state)

	if not index then
		return
	end

	local length = #state.components
	local original_index = index

	repeat
		local next_index = index + direction

		if next_index <= length and next_index >= 1 then
			next_index = index + direction
		elseif index + direction <= 0 then
			next_index = length
		else
			next_index = 1
		end

		local item = state.components[next_index]

		-- only permit switching to buffers which are not currently open in a window
		if rawequal(next(vim.fn.win_findbuf(item.id)), nil) then
			return item
		end

		index = next_index
	until original_index == index

	return nil
end

local function setup_commands()
	local cmd = vim.api.nvim_create_user_command

	cmd("BufferLineCycleWindowlessNext", function()
		M.cycle_hidden(1)
	end, {})

	cmd("BufferLineCycleWindowlessPrev", function()
		M.cycle_hidden(-1)
	end, {})
end

function M.setup()
	setup_commands()
end

return M
