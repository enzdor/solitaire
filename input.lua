local state = require("state")
local entities = require("entities")
local mouse_pos = require("mouse-pos")

love.mousepressed = function(x, y, button)
	x = mouse_pos.getRealX(x)
	y = mouse_pos.getRealY(y)
	if button == 1 then
		-- drag card around
		-- for _, card in ipairs(entity.cards) do
		-- 	if card.type == "card" and x > card.x_pos and x < card.x_pos + state.card.width
		-- 	    and y > card.y_pos and y < card.y_pos + state.card.height then
		-- 		card.dragging.active = true
		-- 		card.dragging.x_diff = x - card.x_pos
		-- 		card.dragging.y_diff = y - card.y_pos
		-- 		state.entity_dragged_id = card.id
		-- 	end
		-- end
	end
end

love.mousereleased = function(x, y, button)
	x = mouse_pos.getRealX(x)
	y = mouse_pos.getRealY(y)
	if button == 1 then
		-- draw card from stock to waste
		if x > entities.entities.stock.x_pos and x < entities.entities.stock.x_pos + state.card.width
		    and y > entities.entities.stock.y_pos and y < entities.entities.stock.y_pos + state.card.height then
			for i = #entities.entities.stock.cards, 1, -1 do
				entities.entities.stock.cards[i].x_pos = entities.entities.waste.x_pos
				entities.entities.stock.cards[i].y_pos = entities.entities.waste.y_pos
				entities.entities.stock.cards[i].x_pos_orig = entities.entities.waste.x_pos
				entities.entities.stock.cards[i].y_pos_orig = entities.entities.waste.y_pos
				entities.entities.stock.cards[i].face_up = true
				entities.entities.waste.cards[#entities.entities.waste.cards + 1] = entities.entities
				    .stock.cards[i]
				table.remove(entities.entities.stock.cards, i)
				return
			end
		end
		-- drag card around
		-- for _, entity in ipairs(entities.entities) do
		-- 	if entity.type == "stock" then
		-- 		for _, card_dragged in ipairs(entity.cards) do
		-- 			if card_dragged.id == state.entity_dragged_id then
		-- 				for _, card_under in ipairs(entity.cards) do
		-- 					if card_under.type == "card" and card_under.id ~= state.entity_dragged_id
		-- 					    and x > card_under.x_pos and x < card_under.x_pos + state.card.width
		-- 					    and y > card_under.y_pos and y < card_under.y_pos + state.card.height
		-- 					then
		-- 						card_dragged.dragging.active = false
		-- 						state.entity_dragged_id = 0
		-- 						card_dragged.x_pos_orig = card_under.x_pos
		-- 						card_dragged.y_pos_orig = card_under.y_pos +
		-- 						    state.card.height / 4
		-- 						card_dragged.x_pos = card_under.x_pos
		-- 						card_dragged.y_pos = card_under.y_pos +
		-- 						    state.card.height / 4
		-- 						return
		-- 					end
		-- 				end
		-- 				card_dragged.x_pos = card_dragged.x_pos_orig
		-- 				card_dragged.y_pos = card_dragged.y_pos_orig
		-- 				card_dragged.dragging.active = false
		-- 				state.entity_dragged_id = 0
		-- 			end
		-- 		end
		-- 	end
		-- end
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
