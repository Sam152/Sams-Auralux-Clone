###
The primary class for our overarching logic.
###
class window.Game

	@PLAYER_COLORS: {
		RED : '#F00',
		GREEN : '#0F0'
		BLUE : '#00F',
	}

	constructor: () ->

		# Create a player
		@players = []
		@players.push(new Player(Game.PLAYER_COLORS.BLUE))

		# And create a random scattering of planets for each.
		_.invoke(@players, 'createRandomPlanets', 5)

		@cursor = new Cursor()

	tick: (state_controls) ->
		_.invoke(@players, 'tick')
		@cursor.tick()

	# Check if units collide and should therefore be destroyed.
	checkUnitCollisions: ->

	# Check if units are occupying a planet enough to own it.
	checkPlanetOwnership: ->

