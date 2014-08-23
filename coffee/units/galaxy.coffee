
class window.Unit_Galaxy
	constructor: ->

		@planets = {}

		details = Game.cache.getJSON("levels")

		# Create Planet
		for planet in details[0]["planets"]
			@planets[planet.id] = new Unit_Planet(planet)

		# Link planets
		for key, planet of @planets
			for id in planet.links

				planet_to_link = @planets[id]

				# Logic link
				planet.link(id, planet_to_link)

				# Show link
				line = Game.add.graphics(0, 0)
				line.lineStyle(2, 0xFFFFFF, 0.2)
				line.moveTo(planet.x, planet.y)
				line.lineTo(planet_to_link.x, planet_to_link.y)

		# Show links
		for key, planet of @planets


	is_stable: ->

		for key, planet of @planets

			if planet.step == 2 && planet.gap == 1
				continue
			else if planet.gap == 0
				continue
			else
				return false

		return true
