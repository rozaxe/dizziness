
do -> # main()

	##
	# Let's initialize the game !

	# Tilemap settings
	tile_size  = 64
	map_width  = 16  # in tile
	map_height = 9   # in tile

	# Force to Canvas for my Firefox
	render     = Phaser.CANVAS

	window.Game = new Phaser.Game(map_width * tile_size, map_height * tile_size, render, "game", null, true, true)

	##
	# Define global variables

	Game.globals =
		tile_size: tile_size
		rotate_duration: 200 # in milliseconds
		move_duration: 1500 # in ms
		line_alpha_out: 0.1
		line_alpha_over: 0.6


	###
		elements: [
				"black"  #0
				"white"  #1
				"red"    #2
				"green"  #3
				"blue"   #4
				"yellow" #5
			]
	###

	# Link all states
	Game.state.add("boot",  State_Boot)
	Game.state.add("load",  State_Load)
	Game.state.add("space", State_Space)

	# Start the game
	Game.state.start("boot")
