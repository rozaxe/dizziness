
window.State_Space =

	create: ->

		@galaxy  = new Unit_Galaxy

		@success = Game.add.text(Game.world.centerX, 150, 'Success', { font: '50px Font', fill: '#ffffff' })
		@success.anchor.setTo(0.5, 0.5)
		@success.alpha = 0


	check: ->

		stable = @galaxy.is_stable()

		if stable
			#alert "Gagné !"
			@success.alpha = 1
			@galaxy.freeze()


	set_timer: ->

		Game.time.events.add(Game.globals.rotate_duration, this.check, this)

	disable_mouse: ->
		@galaxy.disable_mouse()

	update: ->


### DEV
	render: ->

		Game.debug.text(@galaxy.planets[0].gap, 5, 15, "#00FF00")
		Game.debug.text(@galaxy.planets[1].gap, 5, 30, "#00FF00")
		Game.debug.text(@galaxy.planets[2].gap, 5, 45, "#00FF00")
###
