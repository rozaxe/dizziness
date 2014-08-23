
class window.Unit_MiniMap

	constructor: (stable, planets) ->

		# Usefull variable
		mini   = Game.globals.mini_size
		width  = mini * Game.globals.map_width
		height = mini * Game.globals.map_height
		x = Game.world.centerX - width / 2
		y = 16

		# Black readable background
		@rect = Game.add.graphics(0, 0)
		@rect.beginFill(0x050506, 1)
		@rect.drawRect(x, y, width, height)

		# White corner for cap attention
		@tri = Game.add.graphics(0, 0)
		@tri.beginFill(0xFAFAFA, 1)
		@tri.moveTo(Game.world.centerX - 14, 0)
		@tri.lineTo(Game.world.centerX + 14, 0)
		@tri.lineTo(Game.world.centerX, 24)
		@tri.endFill()

		Game.add.tween(@tri).to({y: -5}, 800).to({y: 0}, 800).loop().start()

		for key, planet of planets

			Game.add.sprite(x + planet.tile_x * mini, y + planet.tile_y * mini, "elem_#{stable[key]}")
