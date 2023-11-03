local utf8 = require("utf8")
local world = require("world")
local entities = require("entities")
local input = require("input")
local state = require("state")

math.randomseed(os.time())
love.load = function()
	entities.entities = entities.newEntities()
	state.loading = false
end

love.draw = function()
	local window_width, window_height = love.window.getMode()
	if window_width / window_height > state.screen.ratio then
		local change_rate = window_height / state.screen.height
		love.graphics.translate((window_width - state.screen.width * change_rate) / 2, 0)
		love.graphics.scale(change_rate, change_rate)
	else
		local change_rate = window_width / state.screen.width
		love.graphics.translate(0, (window_height - state.screen.height * change_rate) / 2)
		love.graphics.scale(change_rate, change_rate)
	end

	if not state.loading then
		for _, entity in ipairs(entities.entities) do
			if entity.draw then
				entity:draw()
			end
		end
	end
end

love.focus = function(f)
	input.toggle_focus(f)
end

love.keypressed = function(pressed_key)
	input.press(pressed_key)
end

love.keyreleased = function(released_key)
	if released_key == "backspace" then
		-- get the byte offset to the last UTF-8 character in the string.
		local byteoffset = utf8.offset(state.name, -1)

		if byteoffset then
			-- remove the last UTF-8 character.
			-- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
			state.name = string.sub(state.name, 1, byteoffset - 1)
		end
	end
	input.release(released_key)
end

love.textinput = function(t)
	if string.len(state.name) < 4 then
		if not t:match("%W") then
			state.name = state.name .. string.upper(t)
		end
	end
end

love.update = function(dt)
	for _, entity in ipairs(entities.entities) do
		if entity.id == state.entity_dragged_id then
			entity.x_pos = love.mouse.getX() - entity.dragging.x_diff
			entity.y_pos = love.mouse.getY() - entity.dragging.y_diff
		end
	end
	world:update(dt)
end
