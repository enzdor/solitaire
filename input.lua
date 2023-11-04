local state = require("state")
local entities = require("entities")
local mouse_pos = require("mouse-pos")

love.mousepressed = function(x, y, button)
	x = mouse_pos.getRealX(x)
	y = mouse_pos.getRealY(y)
	if button == 1 then
		for _, entity in ipairs(entities.entities) do
			if entity.type == "card" and x > entity.x_pos and x < entity.x_pos + state.card.width
			    and y > entity.y_pos and y < entity.y_pos + state.card.height then
				entity.dragging.active = true
				entity.dragging.x_diff = x - entity.x_pos
				entity.dragging.y_diff = y - entity.y_pos
				state.entity_dragged_id = entity.id
			end
		end
	end
end

love.mousereleased = function(x, y, button)
	x = mouse_pos.getRealX(x)
	y = mouse_pos.getRealY(y)
	if button == 1 then
		for _, card_dragged in ipairs(entities.entities) do
			if card_dragged.id == state.entity_dragged_id then
				for _, card_under in ipairs(entities.entities) do
					if card_under.type == "card" and card_under.id ~= state.entity_dragged_id
					    and x > card_under.x_pos and x < card_under.x_pos + state.card.width
					    and y > card_under.y_pos and y < card_under.y_pos + state.card.height
					then
						card_dragged.dragging.active = false
						state.entity_dragged_id = 0
						card_dragged.x_pos_orig = card_under.x_pos
						card_dragged.y_pos_orig = card_under.y_pos + state.card.height / 4
						card_dragged.x_pos = card_under.x_pos
						card_dragged.y_pos = card_under.y_pos + state.card.height / 4
						return
					end
				end
				card_dragged.x_pos = card_dragged.x_pos_orig
				card_dragged.y_pos = card_dragged.y_pos_orig
				card_dragged.dragging.active = false
				state.entity_dragged_id = 0
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
