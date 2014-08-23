
class window.Unit_Galaxy
	constructor: ->

		details = Game.cache.getJSON("levels")

		console.log Game.globals.level

		level = Game.globals.level

		@planets = {}
		@lines   = []
		@stable  = details[level].stable

		# Create Planet
		for planet, id in details[level].planets
			@planets[id] = new Unit_Planet(planet)


		# Link planets
		keys_did = []
		for key, planet of @planets

			keys_did.push(parseInt(key))

			for id in planet.links

				planet_to_link = @planets[id]

				# Attach planet to another
				planet.attach(id, planet_to_link)

				unless keys_did.indexOf(id) == -1
					continue

				# Show link
				line = Game.add.graphics(0, 0)
				line.lineStyle(2, 0xFFFFFF, 1)
				line.moveTo(planet.x, planet.y)
				line.lineTo(@planets[id].x, @planets[id].y)

				planet.link(line)
				planet_to_link.link(line)
				@lines.push(line)

		# Create minimap
		new Unit_MiniMap(@stable, @planets)


	is_stable: ->

		for elem, i in @stable

			planet = @planets[i]

			unless planet.range[planet.gap] == elem
				return false

		return true


	update: ->


	freeze: ->

		for key, planet of @planets
			planet.stop()


	disable_mouse: ->

		for key, planet of @planets
			planet.inputEnabled = false
