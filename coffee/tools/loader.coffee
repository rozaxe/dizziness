
##
# Loader helper

window.Load = (type, name, ext, format = null) ->
	Game.load[type](name, "assets/#{name}.#{ext}", null, format)

Load.image = (name) ->
	Load("image", "#{name}", "png")

Load.tilemap = (name) ->
	Load("tilemap", "#{name}", "json", Phaser.Tilemap.TILED_JSON)

Load.sound = (name) ->
	Game.load.audio(name, ["assets/#{name}.wav", "assets/#{name}.mp3"])

Load.json = (name) ->
	Game.load.json(name, "assets/#{name}.json")
