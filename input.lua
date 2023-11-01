local state = require("state")
local entities = require("entities")

love.mousepressed = function(x, y, button)
	if button == 1 then
		for _, entity in ipairs(entities.entities) do
			if entity.type == "card" then
				if x > entity.x_pos and x < entity.x_pos + state.card.width
				    and y > entity.y_pos and y < entity.y_pos + state.card.height then
					entity.dragging.active = true
					entity.dragging.x_diff = x - entity.x_pos
					entity.dragging.y_diff = y - entity.y_pos
					state.entity_dragged = entity.id
				end
			end
		end
	end
end

love.mousereleased = function (x, y, button)
	if button == 1 then
		for _, entity in ipairs(entities.entities) do
			if entity.id == state.entity_dragged then
				entity.dragging.active = false
				state.entity_dragged = 0
			end
		end
	end
end

local press_functions = {
}
local release_functions = {
}

return {
	press = function(pressed_key)
		if press_functions[pressed_key] then
			press_functions[pressed_key]()
		end
	end,
	release = function(released_key)
		if release_functions[released_key] then
			release_functions[released_key]()
		end
	end,
	toggle_focus = function(f)
		if not f and not state.game_over and state.game_started and not state.won and not state.stage_cleared then
			state.paused = true
		end
	end
}
