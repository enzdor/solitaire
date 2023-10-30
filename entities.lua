local board = require("entities.board")
local card = require("entities.card")
local state = require("state")

return {
	newEntities = function()
		local entities = {
			board(),
		}

		local row_width = state.screen.width - 30
		for number = 0, 27 do  -- 51
			local card_x = ((number * 110) % row_width) + 15
			local card_y = (math.floor(number * 110 / row_width) * 140) + 10
			entities[#entities + 1] = card(card_x, card_y)
		end

		return entities
	end,
	entities = {}
}
