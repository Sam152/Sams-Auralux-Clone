###
The primary class for our overarching logic.
###
class window.Game

	@PLAYER_COLORS: {
		RED : {
			hex: '#F00',
			label: 'red',
		},
		GREEN : {
			hex : '#0F0',
			label: 'green',
		},
		BLUE : {
			hex :'#0a7eaa',
			label: 'blue',
		},
		PURPLE : {
			hex :'#707',
			label: 'purple',
		},
		BLACK : {
			hex : '#999',
			label : 'black',
		},
	}

	# Setup the container for the main gameplay.
	constructor: () ->
		# This can be overriden to create different game modes.
		@setupGameplay()
		@createAI()

		# Create a cursor to control the human player.
		@cursor = new Cursor(@human_player)


	tick: (state_controls) ->
		# Tick the required components.
		_.invoke(@players, 'tick')
		_.invoke(@ai, 'tick')
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
		throw new Error('Game mode should override Game::setupGameplay.')

	# Create AI objects for the computer players.
	createAI: () ->
		@ai = []
		for player in @combat_players when player != @human_player
			other_players = []
			for other_player in @players when other_player != player
				other_players.push(other_player)
			@ai.push(new AI(player, other_players, @neutral_player))
