
window.State_Boot =

	# Load "load" state assets
	preload: ->
		# Load's assets

		# DEV -- fps
		Game.time.advancedTiming = true

	create: ->
		# Game's settings
		Game.stage.backgroundColor = '#000000'

		# Run load state
		Game.state.start("load")
