
window.State_Space =

	create: ->

		# Setup the galaxy
		@galaxy  = new Unit_Galaxy

		# Galaxy's name
		@title = Game.add.text(16, 16, @galaxy.name, { font: "40px Geo", fill: "#FFFFFF" })
		Game.add.tween(@title).delay(1000).to({alpha: 0}, 800).start()

		# Success text
		@success = Game.add.text(Game.world.centerX, 150 + 30, "Worlds Stabilized", { font: "70px Geo", fill: "#FFFFFF" })
		@success.anchor.setTo(0.5, 0.5)
		@success.alpha = 0
		@success.visible = false

		# Continue text
		@continue = Game.add.text(Game.world.centerX, Game.world.centerY + 30, "Continue >", {font: "40px Geo", fill: "#FFFFFF"})
		@continue.anchor.setTo(0.5, 0.5)
		@continue.alpha = 0
		@continue.visible = false
		@continue.inputEnabled = true
		@continue.events.onInputDown.add(this.next_level, this)
		@continue.input.useHandCursor = true

		# Sounds
		Game.add.sound("enter").play()
		@winning = Game.add.sound("stable")

		# First party
		if Game.globals.random == false and Game.globals.level == 0

			this.enable_tuto()


	check: ->

		stable = @galaxy.is_stable()

		if stable

			@winning.play()

			@success.visible = true
			@continue.visible = true
			Game.add.tween(@success).to({alpha: 1, y: 150}, 300).start()
			Game.add.tween(@continue).to({alpha: 1, y: Game.world.centerY}, 300).start()
			@galaxy.freeze()


	next_level: ->
		# Cause there no more level
		#++Game.globals.level

		# Enable Random level
		Game.globals.random = true

		# Start new galaxy !
		Game.state.start("space")

	set_timer: ->

		Game.time.events.add(Game.globals.rotate_duration, this.check, this)

	disable_mouse: ->
		@galaxy.disable_mouse()


	enable_tuto: ->

		# Midnight's time
		console.log("MT 00:59")

		# Black background
		@rect = Game.add.graphics(0, 0)
		@rect.beginFill(0x050506, 1)
		@rect.drawRect(0, 0, Game.width, Game.height)

		# Tuto
		@tuto = Game.add.sprite(Game.world.centerX, Game.world.centerY, "tuto_1")
		@tuto.anchor.setTo(0.5, 0.5)
		@tuto.inputEnabled = true

		# Tuto button
		@tuto_next = Game.add.button(806, 456, "next", this.next_tuto, this)
		@tuto_next.input.useHandCursor = true

		# Tuto sound
		@select = Game.add.audio("select")

		@tuto_index = 1

	next_tuto: ->

		@select.play()

		if @tuto_index == 2

			# Destroy tuto
			@rect.destroy()
			@tuto.kill()
			@tuto_next.kill()

		else

			# Update tuto page
			@tuto_index = 2
			@tuto.kill()
			@tuto = Game.add.sprite(Game.world.centerX, Game.world.centerY, "tuto_2")
			@tuto.anchor.setTo(0.5, 0.5)
			@tuto.inputEnabled = true
			@tuto_next.bringToTop()
			@tuto_next.frame = 1
