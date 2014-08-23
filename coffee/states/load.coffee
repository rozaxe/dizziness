
window.State_Load =

	# Load all game assets
	preload: ->

		# World image
		for w in ["2_bw", "2_gr", "1_rgyb"]
			Load.image("world_x#{w}")


		# Level
		Game.load.json("levels", "assets/levels.json")

	create: ->
		# Run load state
		Game.state.start("space")
