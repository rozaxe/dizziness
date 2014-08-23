
window.State_Space =

	create: ->

		@galaxy = new Unit_Galaxy


	check: ->

		stable = @galaxy.is_stable()

		if stable
			alert "Gagné !"


	set_timer: ->

		Game.time.events.add(Game.globals.rotate_duration, this.check, this)

	update: ->
