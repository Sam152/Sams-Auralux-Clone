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
			hex :'#00F',
		},
		BLACK : {
			hex : '#000',
		},
	}

	# How close should units be before they collide.
	@UNIT_COLLISION_SENSITIVITY: 20


	# Setup the conditions of the game. The result must be a @players array and
	# a @combat_players array.
	setupGameplay: () ->
		
		neutral_player = new NeutralPlayer(Game.PLAYER_COLORS.BLACK)
		another_player = new Player(Game.PLAYER_COLORS.RED)
		@human_player = new Player(Game.PLAYER_COLORS.BLUE)

		@players = [neutral_player, another_player, @human_player]
		@combat_players = [another_player, @human_player]

		# Create some randomly laid out planets for each of the players.
		_.invoke(@players, 'createRandomPlanets', 0)

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
		@checkUnitCollisions()

	# Check if units collide and should therefore be destroyed.
	checkUnitCollisions: ->

		collision_found = false

		for player, outer_checked in @combat_players
			for compare_player, inner_checked in @combat_players

				# Ensure we only check each player against eachother once.
				if compare_player == player || outer_checked > inner_checked
					continue

				compare_to_units = compare_player.getUnits()
				units = player.getUnits()

				for unit, outer_unit_checked in units.getAll()
					for compare_unit, inner_unit_checked in compare_to_units.getAll()

						# Ensure we only check the units against eachother once.
						# if outer_unit_checked > inner_unit_checked
						# 	continue

						# When we consider there a collision between some units.
						if unit.getPosition().distanceFrom(compare_unit.getPosition()) < Game.UNIT_COLLISION_SENSITIVITY

							# Wipe them off the face of the earth.
							units.remove(unit)
							compare_to_units.remove(compare_unit)
							
							# We need to break two loops to stop a single unit
							# from wiping out multiple other units.
							break

	# Check if units are occupying a planet enough to own it.
	checkPlanetOwnership: ->

