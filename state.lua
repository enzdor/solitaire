return {
	game_over = false,
	game_started = false,
	loading = true,
	won = false,
	score = 0,
	high_score = false,
	checked_high_score = false,
	name = "NAME",
	text = "",
	card = {
		width = 100,
		height = 130
	},
	high_scores = {
		{score = 0, name="NAME"},
		{score = 0, name="NAME"},
		{score = 0, name="NAME"},
	},
	sounds = {},
	palette = {
		red = { 1,   0,    0,   1 },
		green = { 0,   0.5, 0,   1 },
		blue = { 0,   0, 1,   1 },
		white = { 1,   1,    1,   1 },
	},
	screen = {
		width = 800,
		height = 600,
		ratio = 800 / 600
	},
	entity_dragged_id = 0, -- id of the entity being dragged
}
