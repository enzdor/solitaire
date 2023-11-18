local state = require("state")
local entities = require("entities")
local mouse_pos = require("mouse-pos")

love.mousepressed = function(x, y, button)
	x = mouse_pos.getRealX(x)
	y = mouse_pos.getRealY(y)
	-- drag card around
	if button == 1 then
		for _, entity in pairs(entities.entities) do
			if entity.type ~= "stock" and entity.type ~= "board" then
				for _, card in ipairs(entity.cards) do
					if x > card.x_pos and x < card.x_pos + state.card.width
					    and y > card.y_pos and y < card.y_pos + state.card.height then
						card.dragging.active = true
						card.dragging.x_diff = x - card.x_pos
						card.dragging.y_diff = y - card.y_pos
						state.entity_dragged_id = card.id
					end
				end
			end
		end
	end
end

love.mousereleased = function(x, y, button)
	x = mouse_pos.getRealX(x)
	y = mouse_pos.getRealY(y)
	if button == 1 then
		if x > entities.entities.stock.x_pos and x < entities.entities.stock.x_pos + state.card.width
		    and y > entities.entities.stock.y_pos and y < entities.entities.stock.y_pos + state.card.height then
			if #entities.entities.stock.cards > 0 then
				-- draw card from stock to waste
				for i = #entities.entities.stock.cards, 1, -1 do
					entities.entities.stock.cards[i].x_pos = entities.entities.waste.x_pos
					entities.entities.stock.cards[i].y_pos = entities.entities.waste.y_pos
					entities.entities.stock.cards[i].x_pos_orig = entities.entities.waste.x_pos
					entities.entities.stock.cards[i].y_pos_orig = entities.entities.waste.y_pos
					entities.entities.stock.cards[i].face_up = true
					entities.entities.waste.cards[#entities.entities.waste.cards + 1] = entities
					    .entities
					    .stock.cards[i]
					table.remove(entities.entities.stock.cards, i)
					return
				end
			else
				-- recycle waste
				for i = #entities.entities.waste.cards, 1, -1 do
					entities.entities.waste.cards[i].x_pos = entities.entities.stock.x_pos
					entities.entities.waste.cards[i].y_pos = entities.entities.stock.y_pos
					entities.entities.waste.cards[i].x_pos_orig = entities.entities.stock.x_pos
					entities.entities.waste.cards[i].y_pos_orig = entities.entities.stock.y_pos
					entities.entities.waste.cards[i].face_up = false
					entities.entities.stock.cards[#entities.entities.stock.cards + 1] = entities
					    .entities
					    .waste.cards[i]
					table.remove(entities.entities.waste.cards, i)
				end
			end
		end
		-- drag card around
		-- do for loop over waste and piles and foundations and when
		-- dragged card is found define to a local variable, and rem
		-- ember where the card is from. then check over what card,
		-- or pile or foundation the dragged card is over and move it
		-- to its according place. then add the card to the array of
		-- cards in the pile or foundation, and remove from the pre
		-- vious pile or foundation or waste.

		local card_dragged = {}
		local card_dragged_index = 0
		local card_dragged_key = ""

		for key, entity in pairs(entities.entities) do
			if entity.type ~= "stock" and entity.type ~= "board" then
				for i, card in ipairs(entity.cards) do
					if card.id == state.entity_dragged_id then
						card_dragged = card
						card_dragged_index = i
						card_dragged_key = key
					end
				end
			end
		end

		if card_dragged.type ~= "card" then
			return
		end

		for key, entity in pairs(entities.entities) do
			if entity.type == "foundation" then
				if x > entity.x_pos and x < entity.x_pos + state.card.width
				    and y > entity.y_pos and y < entity.y_pos + state.card.height
				then
					local was_empty = entity.empty
					if entity.empty then
						entity.empty = false
						entity.suit = card_dragged.suit
					end
					if was_empty or entity.suit == card_dragged.suit then
						card_dragged.dragging.active = false
						card_dragged.bottom = false
						state.entity_dragged_id = 0
						card_dragged.x_pos_orig = entity.x_pos
						card_dragged.y_pos_orig = entity.y_pos
						card_dragged.x_pos = entity.x_pos
						card_dragged.y_pos = entity.y_pos
						entities.entities[key].cards[#entities.entities[key].cards + 1] =
						    card_dragged
						table.remove(entities.entities[card_dragged_key].cards,
							card_dragged_index)
					else
						card_dragged.x_pos = card_dragged.x_pos_orig
						card_dragged.y_pos = card_dragged.y_pos_orig
						card_dragged.dragging.active = false
						state.entity_dragged_id = 0
					end
				end
			end


			-- REFACTOR STUFF BELOW
			if entity.type == "pile" then
				if entity.empty and x > entity.x_pos and x < entity.x_pos + state.card.width
				    and y > entity.y_pos and y < entity.y_pos + state.card.height
				then
					entity.empty = false
					card_dragged.dragging.active = false
					card_dragged.bottom = true
					state.entity_dragged_id = 0
					card_dragged.x_pos_orig = entity.x_pos
					card_dragged.y_pos_orig = entity.y_pos
					card_dragged.x_pos = entity.x_pos
					card_dragged.y_pos = entity.y_pos
					entities.entities[key].cards[#entities.entities[key].cards + 1] =
					    card_dragged
					table.remove(entities.entities[card_dragged_key].cards,
						card_dragged_index)
					return
				end
				for _, card_under in ipairs(entity.cards) do
					if card_under.id ~= state.entity_dragged_id
					    and x > card_under.x_pos and x < card_under.x_pos + state.card.width
					    and y > card_under.y_pos and y < card_under.y_pos + state.card.height
					    and card_under.bottom
					then
						card_dragged.dragging.active = false
						card_dragged.bottom = true
						state.entity_dragged_id = 0
						card_dragged.x_pos_orig = card_under.x_pos
						card_dragged.y_pos_orig = card_under.y_pos +
						    state.card.height / 4
						card_dragged.x_pos = card_under.x_pos
						card_dragged.y_pos = card_under.y_pos +
						    state.card.height / 4
						entities.entities[key].cards[#entities.entities[key].cards].bottom = false
						entities.entities[key].cards[#entities.entities[key].cards + 1] =
						    card_dragged
						table.remove(entities.entities[card_dragged_key].cards,
							card_dragged_index)
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
