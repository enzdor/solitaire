local world = require("world")
local state = require("state")

return function (x_pos, y_pos, id)
	local entity = {}

	entity.type = "card"
	entity.id = id
	entity.face_up = false
	entity.suit = "club"
	entity.rank = "A"
	entity.x_pos = x_pos
	entity.y_pos = y_pos
	entity.dragging = {
		active = false,
		x_diff = 0,
		y_diff = 0
	}

	entity.body = love.physics.newBody(world, x_pos + state.card.width / 2, y_pos + state.card.height / 2)
	entity.shape = love.physics.newRectangleShape(state.card.width, state.card.height)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)


	entity.draw = function ()
		love.graphics.setColor(state.palette.red)
		love.graphics.rectangle("fill", entity.x_pos, entity.y_pos, state.card.width, state.card.height)
	end

	return entity
end
