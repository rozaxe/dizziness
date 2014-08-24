
window.State_Boot =

	# Load "load" state assets
	preload: ->
		# Load's assets

		Game.load.image("progress", "assets/progress.png")


	create: ->

		# Run load state
		Game.state.start("load")
