
window.State_Load =

	# Load all game assets
	preload: ->

		# Loading text
		Game.add.text(Game.world.centerX, 150, "Loading", { font: "50px Geo", fill: "#ffffff" }).anchor.setTo(0.5, 0.5)

		# Progress bar
		progress = Game.add.sprite(Game.world.centerX, 250, "progress")
		progress.anchor.setTo(0.5, 0.5)
		Game.load.setPreloadSprite(progress)

		# World image
		for i in [1..2]
			for range in Game.globals.range[i]
				Game.load.image("world_#{range}", "assets/world_#{range}.svg")

		# Tuto
		Game.load.image("tuto_1", "assets/tuto_1.png")
		Game.load.image("tuto_2", "assets/tuto_2.png")

		# Button
		Game.load.spritesheet("next", "assets/next.png", 66, 28)
		Game.load.spritesheet("mute", "assets/mute.png", 32, 32)

		# Elem image
		for i in [0..7]
			Game.load.image("elem_#{i}", "assets/elem_#{i}.png")

		# Cloud image
		for i in [1..Game.globals.cloud_variante]
			Game.load.image("cloud_#{i}", "assets/cloud_#{i}.svg")

		# Levels
		Game.load.json("levels", "assets/levels.json")
		Game.load.json("randoms", "assets/randoms.json")

		# Sound
		for a in ["turn", "select", "enter", "stable"]
			Game.load.audio(a, ["assets/#{a}.wav"])

	create: ->

		# Run load state
		Game.state.start("menu")
