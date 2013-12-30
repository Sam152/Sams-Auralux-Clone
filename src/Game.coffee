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

	# How close should units be before they collide.
	@UNIT_COLLISION_SENSITIVITY: 40


	# Setup the conditions of the game. The result must be a @players array and
	# a @combat_players array.
	setupGameplay: () ->
		
		neutral_player = new NeutralPlayer(Game.PLAYER_COLORS.BLACK)
		@human_player = new Player(Game.PLAYER_COLORS.BLUE)
		red_player = new Player(Game.PLAYER_COLORS.RED)
		green_player = new Player(Game.PLAYER_COLORS.GREEN)

		@players = [
			neutral_player,
			red_player,
			green_player,
			@human_player
		]
		@combat_players = [red_player, @human_player, green_player]

		# Create some randomly laid out planets for each of the players.
		_.invoke(@combat_players, 'createRandomPlanets', 0)

		neutral_player.createRandomPlanets(5)

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

		# Do our game related logic.
		Collisions.resolveCollisions(@combat_players)


	# Check if units are occupying a planet enough to own it.
	checkPlanetOwnership: ->

