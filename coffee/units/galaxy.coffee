
class window.Unit_Galaxy
	constructor: ->

		@planets = {}
		@lines = []

		details = Game.cache.getJSON("levels")

		# Create Planet
		for planet in details[0]["planets"]
			@planets[planet.id] = new Unit_Planet(planet)

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

				console.log "Planet lié : #{key} #{id}"


	is_stable: ->

		for key, planet of @planets

			if planet.step == 2 && planet.gap == 1
				continue
			else if planet.gap == 0
				continue
			else
				return false

		return true


	update: ->
		# TODO Move a little planet
		# TODO Move line according to planet
