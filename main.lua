local utf8 = require("utf8")
local world = require("world")
local entities = require("entities")
local input = require("input")
local state = require("state")
local mouse_pos = require("mouse-pos")

math.randomseed(os.time())
love.load = function()
	entities.entities = entities.newEntities()
	state.loading = false
	state.card.back = love.graphics.newImage("resources/cards/back.png")
end

love.draw = function()
	local window_width, window_height = love.window.getMode()
	if window_width / window_height > state.screen.ratio then
		local change_rate = window_height / state.screen.height
		local x_translate = (window_width - state.screen.width * change_rate) / 2
		state.screen.change_rate = change_rate
		state.screen.x_translate = x_translate
		love.graphics.translate(x_translate, 0)
		love.graphics.scale(change_rate, change_rate)
	else
		local change_rate = window_width / state.screen.width
		local y_translate = (window_height - state.screen.height * change_rate) / 2
		state.screen.y_translate = y_translate
		state.screen.change_rate = change_rate
		love.graphics.translate(0, y_translate)
		love.graphics.scale(change_rate, change_rate)
	end

	if not state.loading then
		entities.entities.board:draw()
		entities.entities.stock:draw()
		entities.entities.waste:draw()
		entities.entities.pile1:draw()
		entities.entities.foundation1:draw()
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
	for _, card in ipairs(entities.entities.waste.cards) do
		if card.id == state.entity_dragged_id then
			local x = mouse_pos.getRealX(love.mouse.getX())
			local y = mouse_pos.getRealY(love.mouse.getY())
			card.x_pos = x - card.dragging.x_diff
			card.y_pos = y - card.dragging.y_diff
		end
	end
	for i, card in ipairs(entities.entities.pile1.cards) do
		if card.id == state.entity_dragged_id then
			local x = mouse_pos.getRealX(love.mouse.getX())
			local y = mouse_pos.getRealY(love.mouse.getY())
			if state.group_dragged then
				local cards_drawn = 0
				for j = i, #entities.entities.pile1.cards do
					entities.entities.pile1.cards[j].x_pos = x - entities.entities.pile1.cards[j].dragging.x_diff
					entities.entities.pile1.cards[j].y_pos = y -
							entities.entities.pile1.cards[j].dragging.y_diff + cards_drawn * state.card.height / 4
					cards_drawn = cards_drawn + 1
				end
			else
				card.x_pos = x - card.dragging.x_diff
				card.y_pos = y - card.dragging.y_diff
			end
		end
	end
	for _, card in ipairs(entities.entities.foundation1.cards) do
		if card.id == state.entity_dragged_id then
			local x = mouse_pos.getRealX(love.mouse.getX())
			local y = mouse_pos.getRealY(love.mouse.getY())
			card.x_pos = x - card.dragging.x_diff
			card.y_pos = y - card.dragging.y_diff
		end
	end
	world:update(dt)
end
