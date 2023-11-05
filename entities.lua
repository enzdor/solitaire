local board = require("entities.board")
local card = require("entities.card")
local stock = require("entities.stock")
local waste = require("entities.waste")
local pile = require("entities.pile")
local state = require("state")

return {
	newEntities = function()
		local entities = {
			board = board(),
			stock = stock(15, 10),
			waste = waste(state.card.width + 25, 10),
			pile1 = pile(15, 150),
		}

		-- draw 52 cards (can probably do this better with modulo)
		for i = 1, 52 do
			if i < 14 then
				entities.stock.cards[#entities.stock.cards + 1] = card(entities.stock.x_pos,
					entities.stock.y_pos, math.random(0, 1000000), state.card.suits[1],
					state.card.ranks[i])
			elseif i < 27 then
				entities.stock.cards[#entities.stock.cards + 1] = card(entities.stock.x_pos,
					entities.stock.y_pos, math.random(0, 1000000), state.card.suits[2],
					state.card.ranks[i - 13])
			elseif i < 40 then
				entities.stock.cards[#entities.stock.cards + 1] = card(entities.stock.x_pos,
					entities.stock.y_pos, math.random(0, 1000000), state.card.suits[3],
					state.card.ranks[i - 26])
			else
				entities.stock.cards[#entities.stock.cards + 1] = card(entities.stock.x_pos,
					entities.stock.y_pos, math.random(0, 1000000), state.card.suits[4],
					state.card.ranks[i - 39])
			end
		end

		-- cover board with cards
		-- for number = 0, 27 do  -- 27 to fill screen
		-- 	local card_x = ((number * 110) % row_width) + 15
		-- 	local card_y = (math.floor(number * 110 / row_width) * 140) + 10
		-- 	entities[#entities + 1] = card(card_x, card_y, math.random(0, 1000000))
		-- end

		return entities
	end,
	entities = {}
}
