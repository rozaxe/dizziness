
class window.Unit_Planet extends Phaser.Sprite

	constructor: (data) ->

		# Remember from data

		@tile_x = data.x * Game.globals.tile_size
		@tile_y = data.y * Game.globals.tile_size

		@gap    = data.gap
		@step   = data.step * data.direct
		@direct = data.direct
		@links  = data.links
		@linked = {}
		@lines = []

		# Display planet
		super(Game, @tile_x,  @tile_y, "world_x#{data.step}_#{data.color}")
		@anchor.setTo(0.5, 0.5)

		# Enable input and cursor for this sprite
		@inputEnabled = true
		@events.onInputDown.add(this.click, this)
		@events.onInputOver.add(this.over, this)
		@events.onInputOut.add(this.out, this)
		@input.useHandCursor = true

		# Set angle to position
		@angle = -45 + 90 * @gap

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

		this.rotates(@step)
		for key, planet of @linked
			planet.rotates(@step)

		State_Space.set_timer()


	rotates: (step) ->

		# Update position
		@gap = (@gap + step) % 4

		# Animate to new position
		new_angle = @angle + step * 90
		Game.add.tween(this).to({angle: new_angle}, Game.globals.rotate_duration).start()


	# Highlight connected
	over: ->
		for line in @lines
			line.alpha = Game.globals.line_alpha_over

	out: ->
		for line in @lines
			line.alpha = Game.globals.line_alpha_out
