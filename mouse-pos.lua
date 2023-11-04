local state = require("state")

return {
	getRealX = function(x)
		x = x - state.screen.x_translate
		x = x / state.screen.change_rate
	end,
	getRealY = function(y)
		y = y - state.screen.y_translate
		y = y / state.screen.change_rate
	end
}
