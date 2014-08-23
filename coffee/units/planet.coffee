
class window.Unit_Planet extends Phaser.Sprite

	constructor: (data) ->

		# Remember from data
		@gap    = data.gap
		@range  = data.range
		@direct = data.direct
		@step   = data.step
		@links  = data.links  # array:num > Id for connected planet
		@linked = {}          # object:planet > Connected planet
		@lines  = []          # array:line > Graphical line

		# Calculed data
		@tile_x = data.x * Game.globals.tile_size
		@tile_y = data.y * Game.globals.tile_size

		# Display planet
		color = ""
		for c in @range
			color += c

		super(Game, @tile_x,  @tile_y, "world_#{color}")
		@anchor.setTo(0.5, 0.5)
		@scale.setTo(data.scale, data.scale)

		# Enable input and cursor for this sprite
		@inputEnabled = true
		@events.onInputDown.add(this.click, this)
		@events.onInputOver.add(this.over, this)
		@events.onInputOut.add(this.out, this)
		@input.useHandCursor = true

		# Set angle to position
		@angle = -45 + 90 * @gap

		# Animate
		disp = Game.rnd.integerInRange(3, 8) * Phaser.Math.randomSign()
		top = @tile_y - disp
		bottom = @tile_y + disp
		Game.add.tween(this).to({y: top}, Game.globals.move_duration).to({y: bottom}, Game.globals.move_duration).loop().start()

		# If set, freeze actions
		@freezed = false

		# Show it !
		Game.add.existing(this)


	# Attach planet
	attach: (id, planet) ->
		@linked[id] = planet


	# Attach line:graphic
	link: (line) ->
		@lines.push(line)
		this.bringToTop()
		for line in @lines
			line.alpha = 0.2


	# World clicked
	click: ->

		if @freezed
			return

		this.rotates(@step, @direct)
		for key, planet of @linked
			planet.rotates(@step, @direct)

		State_Space.set_timer()


	rotates: (step, direct) ->

		# Update position
		@gap = (@gap + step + 4) % 4

		# Animate to new position
		new_angle = @angle + step * 90 * direct
		Game.add.tween(this).to({angle: new_angle}, Game.globals.rotate_duration).start()


	stop: ->
		@freezed = true

		for line in @lines
			#line.alpha = 0
			Game.add.tween(line).to({alpha: 0}, 100).start()

	# Highlight links
	over: ->
		if @freezed
			return
		for line in @lines
			line.alpha = Game.globals.line_alpha_over

	out: ->
		if @freezed
			return State_Space.disable_mouse()

		for line in @lines
			line.alpha = Game.globals.line_alpha_out
