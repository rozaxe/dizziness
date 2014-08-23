
window.State_Menu =

	create: ->

		details = Game.cache.getJSON("levels")

		title = Game.add.text(Game.world.centerX, 150, "Dizziness", { font: "64px Geo", fill: "#ffffff" })
		title.anchor.setTo(0.5, 0.5)

		@index = 0

		# No localstorage
		niveau = Game.add.text(Game.world.centerX, Game.world.centerY, "Click to stabilize", {font: "30px Geo", fill: "#ffffff"})
		#niveau = Game.add.text(Game.world.centerX, Game.world.centerY, "#{details[@index].title}", {font: "50px Geo", fill: "#ffffff"})
		niveau.anchor.setTo(0.5, 0.5)

		Game.add.tween(niveau).to({y: niveau.y + 8}, 900).to({y: niveau.y}, 900).loop().start()

		Game.input.onDown.add(this.click, this)

	click: ->

		Game.state.start("space")
