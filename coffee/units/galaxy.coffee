
class window.Unit_Galaxy
	constructor: ->

		@planets = {}
		@lines   = []
		@stable  = []
		@name = ""

		if Game.globals.random

			this.create_random()

		else

			this.create_level()


	create_random: ->

		# Midnight's time
		console.log("MT 0#{Game.rnd.integerInRange(1, 3)}:#{Game.rnd.integerInRange(0, 5)}#{Game.rnd.integerInRange(0, 9)}")

		# Random name
		@name = "#{Game.rnd.pick(Game.globals.name_type)}  *#{Game.rnd.pick(Game.globals.name_char)}#{Game.rnd.pick(Game.globals.name_char)}#{Game.rnd.pick(Game.globals.name_char)}"

		level = Game.rnd.pick(Game.cache.getJSON("randoms"))

		for data, i in level.planets

			# New step and gap
			step = Game.rnd.integerInRange(1, 2)
			gap  = Game.rnd.integerInRange(0, 3)

			# Attach simple data to planet
			data.step = step
			data.gap  = gap
			data.direct = 1 #* Phaser.Math.randomSign()

			# Attach range date
			str = Game.rnd.pick(Game.globals.range[step])

			range = []
			for j in [0...str.length]
				range.push parseInt(str[j])

			data.range = range

			# Stable state
			@stable.push(data.range[gap])

			# Create planet
			@planets[i] = new Unit_Planet(data)


		# Links between planets
		this.link_planets()

		# Shuffle planets
		for i in [0..Game.rnd.integerInRange(1, 3)]
			keys = Object.keys(@planets)
			id = Game.rnd.pick(keys)
			@planets[id].virtual_click()


	create_level: ->

		details = Game.cache.getJSON("levels")

		level = Game.globals.level

		@stable  = details[level].stable

		# Create Planet
		for planet, id in details[level].planets
			@planets[id] = new Unit_Planet(planet)


		this.link_planets()

	link_planets: ->

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


	freeze: ->

		for key, planet of @planets
			planet.stop()


	disable_mouse: ->

		for key, planet of @planets
			planet.inputEnabled = false
