
window.State_Menu =

	create: ->

		# Ugly but neccesaary
		@out_of = true

		# Display title
		title = Game.add.text(Game.world.centerX, 150, "Dizziness", { font: "64px Geo", fill: "#FFFFFF" })
		title.anchor.setTo(0.5, 0.5)

		# Display start button
		niveau = Game.add.text(Game.world.centerX, Game.world.centerY, "Click to stabilize", {font: "30px Geo", fill: "#FFFFFF"})
		niveau.anchor.setTo(0.5, 0.5)
		Game.add.tween(niveau).to({y: niveau.y + 8}, 900).to({y: niveau.y}, 900).loop().start()

		# Complexity
		Game.add.text(Game.world.centerX, Game.world.centerY + 150, "Complexity", {font: "24px Geo", fill: "#FFFFFF"}).anchor.setTo(0.5, 0.5)

		# Minus
		minus = Game.add.text(Game.world.centerX - 70, Game.world.centerY + 150, "-", {font: "30px Geo", fill: "#FFFFFF"})
		minus.anchor.setTo(0.5, 0.5)
		minus.inputEnabled = true
		minus.events.onInputDown.add(this.minus_complexity, this)
		minus.events.onInputOver.add((-> @out_of = false), this)
		minus.events.onInputOut.add((-> @out_of = true), this)
		minus.input.useHandCursor = true

		# Plus
		plus = Game.add.text(Game.world.centerX + 70, Game.world.centerY + 150, "+", {font: "30px Geo", fill: "#FFFFFF"})
		plus.anchor.setTo(0.5, 0.5)
		plus.inputEnabled = true
		plus.events.onInputDown.add(this.plus_complexity, this)
		plus.events.onInputOver.add((-> @out_of = false), this)
		plus.events.onInputOut.add((-> @out_of = true), this)
		plus.input.useHandCursor = true

		# Complexity stars
		@stars = Game.add.text(Game.world.centerX, Game.world.centerY + 180, "", {font: "30px Geo", fill: "#FFFFFF"})
		@stars.anchor.setTo(0.5, 0.5)
		this.update_stars()

		# Mute button
		@mute = Game.add.button(32, 32, "mute", this.toggle, this)
		@mute.frame = if Game.sound.mute then 1 else 0
		@mute.events.onInputOver.add((-> @out_of = false), this)
		@mute.events.onInputOut.add((-> @out_of = true), this)
		@mute.input.useHandCursor = true

		# Sound
		@select = Game.add.audio("select")

		Game.input.onDown.add(this.click, this)


	update_stars: ->
		str = ""
		for i in [0...Game.globals.complexity]
			str += "*"

		@stars.text = str


	minus_complexity: ->
		this.complexity(-1)


	plus_complexity: ->
		this.complexity(1)


	complexity: (step) ->

		@select.play()

		complexity = Phaser.Math.max(1, Game.globals.complexity + step)
		Game.globals.complexity = Phaser.Math.min(3, complexity)

		this.update_stars()

	toggle: ->

		Game.sound.mute = !Game.sound.mute
		@mute.frame = if Game.sound.mute then 1 else 0


	click: ->

		unless @out_of
			return

		# Start game
		Game.state.start("space")
