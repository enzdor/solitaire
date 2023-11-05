return function (x_pos, y_pos)
	local entity = {}

	entity.x_pos = x_pos
	entity.y_pos = y_pos
	entity.type = "waste"
	entity.cards = {}

	entity.draw = function (self)
		for _, card in ipairs(self.cards) do
			card.draw()
		end
	end

	return entity
end
