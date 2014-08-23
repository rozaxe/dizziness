
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

		# Display planet
		super(Game, @tile_x,  @tile_y, "world_x#{data.step}_#{data.color}")
		@anchor.setTo(0.5, 0.5)

		# Enable input and cursor for this sprite
		@inputEnabled = true
		@events.onInputDown.add(this.click, this)
		@input.useHandCursor = true

		# Set angle to position
		@angle = -45 + 90 * @gap

		# Show it !
		Game.add.existing(this)


	link: (id, planet) ->
		@linked[id] = planet

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
