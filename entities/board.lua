local world = require("world")
local state = require("state")

return function ()
	local entity = {}

	entity.body = love.physics.newBody(world, state.screen.width / 2, state.screen.height / 2)
	entity.shape = love.physics.newRectangleShape(state.screen.width, state.screen.height)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)

	entity.type = "board"

	entity.draw = function (self)
		love.graphics.setColor(state.palette.green)
		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
	end

	return entity
end
