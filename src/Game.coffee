###
The primary class for our overarching logic.
###
class window.Game
	constructor: () ->

		@players = []
		@players.push(new Player())

	tick: (state_controls) ->
		_.invoke(@players, 'tick')
