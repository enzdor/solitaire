local world = require("world")
local state = require("state")

return function(x_pos, y_pos)
	local entity = {}

	entity.body = love.physics.newBody(world, x_pos + state.card.width / 2, y_pos + state.card.height / 2, "static")
	entity.shape = love.physics.newRectangleShape(state.card.width, state.card.height)
	entity.fixture = love.physics.newFixture(entity.body, entity.shape)
	entity.fixture:setUserData(entity)

	entity.x_pos = x_pos
	entity.y_pos = y_pos
	entity.type = "pile"
	entity.cards = {}

	entity.draw = function(self)
		love.graphics.setColor(state.palette.dark_green)
		love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
		for _, card in ipairs(self.cards) do
			card.draw()
		end
	end

	return entity
end
