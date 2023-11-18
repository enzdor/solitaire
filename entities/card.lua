local state = require("state")

return function(x_pos, y_pos, id, suit, rank, belongs_to)
	local entity = {}

	entity.belongs_to = belongs_to
	entity.type = "card"
	entity.id = id
	entity.face_up = false
	entity.suit = suit
	entity.rank = rank
	entity.x_pos = x_pos
	entity.y_pos = y_pos
	entity.x_pos_orig = x_pos
	entity.y_pos_orig = y_pos
	entity.bottom = false
	entity.dragging = {
		active = false,
		x_diff = 0,
		y_diff = 0
	}

	entity.sprite_front = love.graphics.newImage("resources/cards/" .. rank .. "_" .. suit .. ".png")

	entity.draw = function()
		love.graphics.setColor(state.palette.white)
		if entity.face_up then
			love.graphics.draw(entity.sprite_front, entity.x_pos, entity.y_pos, 0, 0.39, 0.365)
		else
			love.graphics.draw(state.card.back, entity.x_pos, entity.y_pos, 0, 0.39, 0.365)
		end
	end

	return entity
end
