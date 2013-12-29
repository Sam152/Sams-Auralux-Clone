###
The primary class for our overarching logic.
###
class window.Game
	constructor: () ->

		# Create a player
		@players = []
		@players.push(new Player())

		# And create a random scattering of planets for each.
		_.invoke(@players, 'createRandomPlanets', 5)

	tick: (state_controls) ->
		_.invoke(@players, 'tick')
