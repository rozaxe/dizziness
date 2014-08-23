
window.State_Load =

	# Load all game assets
	preload: ->

		Game.add.text(Game.world.centerX, 150, "Loading", { font: "50px Geo", fill: "#ffffff" }).anchor.setTo(0.5, 0.5)

		# World image
		for range in [ "0011", "2211", "2233", "2354" ]
			Game.load.image("world_#{range}", "assets/world_#{range}.svg")

		# Tuto
		Load.image("tuto_1")
		Load.image("tuto_2")

		# Tuto Button
		Game.load.spritesheet("next", "assets/next.png", 66, 28)

		# Elem image
		for i in [0..3]
			Load.image("elem_#{i}")

		# Level
		Game.load.json("levels", "assets/levels.json")

	create: ->

		# Run load state
		Game.state.start("menu")
