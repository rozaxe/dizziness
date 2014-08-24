
class window.Unit_MiniMap

	constructor: (stable, planets) ->

		# Usefull variable
		mini   = Game.globals.mini_size
		width  = mini * Game.globals.map_width
		height = mini * Game.globals.map_height
		x = Game.world.centerX - width / 2
		y = 16

		# White corner for cap attention
		tri = Game.add.graphics(0, 0)
		tri.beginFill(0xFAFAFA, 1)
		tri.moveTo(Game.world.centerX - 14, 0)
		tri.lineTo(Game.world.centerX + 14, 0)
		tri.lineTo(Game.world.centerX, 24)
		tri.endFill()

		# Return to menu
		sprite = Game.add.sprite(Game.world.centerX, 0, tri.generateTexture())
		sprite.anchor.setTo(0.5, 0)
		Game.add.tween(sprite).to({y: -5}, 800).to({y: 0}, 800).loop().start()
		sprite.inputEnabled = true
		sprite.events.onInputDown.add(this.to_menu, this)
		sprite.input.useHandCursor = true
		tri.destroy()

		@bip = Game.add.audio("select")

		# Display stable element
		for key, planet of planets

			Game.add.sprite(x + planet.tile_x * mini, y + planet.tile_y * mini, "elem_#{stable[key]}")


	to_menu: ->

		@bip.play()

		Game.state.start("menu")
