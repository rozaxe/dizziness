
window.State_Load =

	# Load all game assets
	preload: ->

		# World image
		#for w in ["1001", "2332"]
		#	Load.image("world_#{w}")

		for range in [ "0011", "2233", "2354" ]
			Game.load.image("world_#{range}", "assets/world_#{range}.svg")

		for i in [0..3]
			Load.image("elem_#{i}")

		# Level
		Game.load.json("levels", "assets/levels.json")

	create: ->
		# Run load state
		Game.state.start("space")
