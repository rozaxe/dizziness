
window.State_Load =

	# Load all game assets
	preload: ->

		# Loading text
		Game.add.text(Game.world.centerX, 150, "Loading", { font: "50px Geo", fill: "#ffffff" }).anchor.setTo(0.5, 0.5)

		# World image
		for i in [1..2]
			for range in Game.globals.range[i]
				Game.load.image("world_#{range}", "assets/world_#{range}.svg")

		# Tuto
		Game.load.image("tuto_1", "assets/tuto_1.png")
		Game.load.image("tuto_2", "assets/tuto_2.png")

		# Tuto Button
		Game.load.spritesheet("next", "assets/next.png", 66, 28)

		# Elem image
		for i in [0..7]
			Game.load.image("elem_#{i}", "assets/elem_#{i}.png")

		# Levels
		Game.load.json("levels", "assets/levels.json")
		Game.load.json("randoms", "assets/randoms.json")

		# Sound
		for a in ["turn", "select", "enter"]
			Game.load.audio(a, ["assets/#{a}.wav"])

	create: ->

		# Run load state
		Game.state.start("menu")
