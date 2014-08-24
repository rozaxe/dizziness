
window.State_Menu =

	create: ->

		# Display title
		title = Game.add.text(Game.world.centerX, 150, "Dizziness", { font: "64px Geo", fill: "#FFFFFF" })
		title.anchor.setTo(0.5, 0.5)

		# Display start button
		niveau = Game.add.text(Game.world.centerX, Game.world.centerY, "Click to stabilize", {font: "30px Geo", fill: "#FFFFFF"})
		niveau.anchor.setTo(0.5, 0.5)

		Game.add.tween(niveau).to({y: niveau.y + 8}, 900).to({y: niveau.y}, 900).loop().start()

		Game.input.onDown.add(this.click, this)


	click: ->

		# Start game
		Game.state.start("space")
