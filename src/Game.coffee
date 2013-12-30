###
The primary class for our overarching logic.
###
class window.Game

	@PLAYER_COLORS: {
		RED : {
			hex: '#F00',
		},
		GREEN : {
			hex : '#0F0'
		},
		BLUE : {
			hex :'#0a7eaa',
		},
		BLACK : {
			hex : '#999',
		},
	}



	# Setup the container for the main gameplay.
	constructor: () ->
		# This can be overriden to create different game modes.
		@setupGameplay()

		# Create a cursor to control the human player.
		@cursor = new Cursor(@human_player)


	tick: (state_controls) ->
		# Tick the required components.
		_.invoke(@players, 'tick')
		@cursor.tick()

		# Do the primary game related logic.
		Collisions.resolveCollisions(@combat_players)
		Ownership.checkPlanetOwnership(@players, @neutral_player)


	# Setup the conditions of the game. The result must be a @players array and
	# a @combat_players array. @human_player and @neutral_player must also be
	# set.
	setupGameplay: () ->
		@human_player
		@neutral_player
		@combat_players
		@players
		throw Error('Game mode should override Game::setupGameplay.')
