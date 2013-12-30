###
The primary class for our overarching logic.
###
class window.Game

	@PLAYER_COLORS: {
		RED : '#F00',
		GREEN : '#0F0'
		BLUE : '#00F',
		BLACK : '#000',
	}

	# How close should units be before they collide.
	@UNIT_COLLISION_SENSITIVITY: 20

	constructor: () ->

		# Create the human player.
		@human_player = new Player(Game.PLAYER_COLORS.BLUE)

		# Create a general array of players.
		@players = []
		@players.push(@human_player)
		@players.push(new Player(Game.PLAYER_COLORS.RED))
		@players.push(new Player(Game.PLAYER_COLORS.GREEN))
		@players.push(new Player(Game.PLAYER_COLORS.BLACK))

		# And create a random scattering of planets for each.
		_.invoke(@players, 'createRandomPlanets', 0)
		
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

		for player, outer_checked in @players
			for compare_player, inner_checked in @players

				# Ensure we only check each player against eachother once.
				if compare_player == player || outer_checked > inner_checked
					continue

				console.log('Comparing player ' + player.color + ' and ' + compare_player.color)

				compare_to_units = compare_player.getUnits()
				units = player.getUnits()

				for unit, outer_unit_checked in units.getAll()
					for compare_unit, inner_unit_checked in compare_to_units.getAll()

						# Ensure we only check the units against eachother once.
						if outer_unit_checked > inner_unit_checked
							continue

						# When we consider there a collision between some units.
						if unit.getPosition().distanceFrom(compare_unit.getPosition()) < Game.UNIT_COLLISION_SENSITIVITY

							# Wipe them off the face of the earth.
							units.remove(unit)
							compare_to_units.remove(compare_unit)
							
							# We need to break two loops to stop a single unit
							# from wiping out multiple other units.
							break		



		# throw new Error('a')

	# Check if units are occupying a planet enough to own it.
	checkPlanetOwnership: ->

