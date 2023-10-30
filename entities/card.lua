local world = require("world")
local state = require("state")

return function (x_pos, y_pos)
	local entity = {}

	entity.body = love.physics.newBody(world, x_pos + 100 / 2, y_pos + 130 / 2)
	entity.shape = love.physics.newRectangleShape(state.card.width, state.card.height)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)

	entity.draw = function (self)
		love.graphics.setColor(state.palette.red)
		love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	end

	return entity
end
