
do -> # main()

	##
	# Let's initialize the game !

	# Tilemap settings
	tile_size  = 64
	map_width  = 16  # in tile
	map_height = 10   # in tile

	# Force to Canvas
	render = Phaser.CANVAS

	# Init the all
	window.Game = new Phaser.Game(map_width * tile_size, map_height * tile_size, render, "game", null, true, true)

	##
	# Define global variables

	Game.globals =
		tile_size: tile_size
		mini_size: 10
		map_width: map_width
		map_height: map_height
		rotate_duration: 200  # in milliseconds
		move_duration: 1500   # in ms
		cloud_duration: 40000 # in ms
		cloud_variante: 5
		line_alpha_out: 0 # 0.1
		line_alpha_over: 0.4

		level: 0      # Current level
		random: false # Random level
		complexity: 1

		range:
			1: [
				"0123", "0234"
				"1012", "1555"
				"4062", "4453", "4567",
				"6624"
				"7061"
			]
			2: [
				"0011"
				"2211", "2233", "2266"
				"3300", "3311"
				"4455"
				"6677"
				"7755"
			]

		name_type: [
			"cluster", "globular", "galaxy", "system", "sector", "zone", "area"
		]

		name_char: [
			"1", "2", "3", "4", "5", "6", "7", "8", "9"
		]


	# Link all states
	Game.state.add("boot",  State_Boot)
	Game.state.add("load",  State_Load)
	Game.state.add("menu", State_Menu)
	Game.state.add("space", State_Space)

	# Start the game
	Game.state.start("boot")
