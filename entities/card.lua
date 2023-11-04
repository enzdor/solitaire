local world = require("world")
local state = require("state")

return function(x_pos, y_pos, id)
	local entity = {}

	entity.type = "card"
	entity.id = id
	entity.face_up = false
	entity.suit = "club"
	entity.rank = "A"
	entity.x_pos = x_pos
	entity.y_pos = y_pos
	entity.x_pos_orig = x_pos
	entity.y_pos_orig = y_pos
	entity.dragging = {
		active = false,
		x_diff = 0,
		y_diff = 0
	}

	entity.sprite = love.graphics.newImage("resources/cards/7_clubs.png")

	entity.draw = function()
		love.graphics.setColor(state.palette.white)
		-- love.graphics.rectangle("fill", entity.x_pos, entity.y_pos, state.card.width, state.card.height)
		love.graphics.draw(entity.sprite, entity.x_pos, entity.y_pos, 0, 0.39, 0.365)
	end

	return entity
end
