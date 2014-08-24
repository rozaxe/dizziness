
window.State_Space =

	create: ->

		# Setup the galaxy
		@galaxy  = new Unit_Galaxy

		# Galaxy's name
		#@title = Game.add.text(Game.world.centerX, Game.world.centerY, @galaxy.name, { font: "40px Geo", fill: "#FFFFFF" })
		@title = Game.add.text(16, 16, @galaxy.name, { font: "40px Geo", fill: "#FFFFFF" })
		#@title.anchor.setTo(0.5, 0.5)
		Game.add.tween(@title).delay(1000).to({alpha: 0}, 800).start()

		# Success text
		@success = Game.add.text(Game.world.centerX, 150, "Worlds Stabilized", { font: "70px Geo", fill: "#FFFFFF" })
		@success.anchor.setTo(0.5, 0.5)
		@success.visible = false

		# Continue text
		@continue = Game.add.text(Game.world.centerX, Game.world.centerY, "Continue >", {font: "40px Geo", fill: "#FFFFFF"})
		@continue.anchor.setTo(0.5, 0.5)
		@continue.visible = false
		@continue.inputEnabled = true
		@continue.events.onInputDown.add(this.next_level, this)
		@continue.input.useHandCursor = true

		if Game.globals.randoms == false and (Game.globals.level == 0 or Game.globals.level == 1)

			# Midnight's time
			console.log("MT 00:59")

			@rect = Game.add.graphics(0, 0)
			@rect.beginFill(0x050506, 1)
			@rect.drawRect(0, 0, Game.width, Game.height)

			# Tuto
			@tuto = Game.add.sprite(Game.world.centerX, Game.world.centerY, "tuto_1")
			@tuto.anchor.setTo(0.5, 0.5)

			@tuto_next = Game.add.button(806, 456, "next", this.next_tuto, this)
			@tuto_next.input.useHandCursor = true

			@tuto_index = 1


	check: ->

		stable = @galaxy.is_stable()

		if stable
			#alert "Gagné !"
			@success.alpha = 1
			#@continue.alpha = 1
			@continue.visible = true
			@galaxy.freeze()


	next_level: ->
		++Game.globals.level
		Game.state.start("space")

	set_timer: ->

		Game.time.events.add(Game.globals.rotate_duration, this.check, this)

	disable_mouse: ->
		@galaxy.disable_mouse()



	next_tuto: ->

		if @tuto_index == 2
			@rect.destroy()
			@tuto.kill()
			@tuto_next.kill()

		else

			@tuto_index = 2
			@tuto.kill()
			@tuto = Game.add.sprite(Game.world.centerX, Game.world.centerY, "tuto_2")
			@tuto.anchor.setTo(0.5, 0.5)
			@tuto_next.bringToTop()
			@tuto_next.frame = 1

		### DEV
	render: ->

		Game.debug.text(@galaxy.planets[0].gap, 5, 15, "#00FF00")
		Game.debug.text(@galaxy.planets[1].gap, 5, 30, "#00FF00")
		Game.debug.text(@galaxy.planets[2].gap, 5, 45, "#00FF00")
		###
