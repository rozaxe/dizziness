
do -> # main()

	##
	# Let's initialize the game !

	# Tilemap settings
	tile_size  = 64 # in pixel
	map_width  = 16 # in tile
	map_height = 9  # in tile

	# Force to Canvas for my Firefox
	render     = Phaser.CANVAS

	window.Game = new Phaser.Game(tile_size * map_width, tile_size * map_height, render, "game")

	##
	# Define global variables

	Game.globals =
		tile_size: 64
		rotate_duration: 200 # in milliseconds
		line_alpha_out: 0.1
		line_alpha_over: 0.6

	# Link all states
	Game.state.add("boot",  State_Boot)
	Game.state.add("load",  State_Load)
	Game.state.add("space", State_Space)

	# Start the game
	Game.state.start("boot")
