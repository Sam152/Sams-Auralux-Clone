###
Manage who owns what.
###
class window.Ownership

	# How often we should check for the new ownership of a planet.
	@OWNERSHIP_CHECK_FREQUENCY: 20

	# How many units need to be covering a planet to take it over.
	@UNIT_COVERAGE_REQUIREMENT: 60

	# Check if any planets need to transfer ownership.
	@checkPlanetOwnership: (players, neutral_player) ->

		# Run expensive operations infrequently.
		Schedule.runEvery(Ownership.OWNERSHIP_CHECK_FREQUENCY, ->
			for player in players
				for compare_player in players

					# No need to check if the neutral players units are concouring
					# the world.
					if compare_player == neutral_player || player == compare_player
						continue

					# Get the units we will be testing.
					opponents_units = compare_player.getUnits()

					if player.color.hex == Game.PLAYER_COLORS.BLUE
						console.log('Checking human planets against '  + compare_player.color.hex)

					# Test each planet of the player we are testing.
					for planet in player.getPlanets()
						
						occupying_units = []

						# Check each unit of opponent player.
						for unit in opponents_units.getAll()

							# If they intersect with the planet, they are a
							# candidate to take the planet over.
							if unit.getPosition().intersectsWith(planet.getPosition())
								occupying_units.push(unit)

								# If we find there are enoguh units, transfer the
								# ownership of the planet and move on to the next
								# one
								if occupying_units.length > Ownership.UNIT_COVERAGE_REQUIREMENT
									Ownership.transferOwnership(planet, occupying_units, compare_player, player)
									break

		,@)

	# Move the ownership of a planet from one person to another.
	# @todo, clean this up with a PlanetCollection.
	@transferOwnership: (planet, units, player, old_player) ->
		
		# Remove the units responsive for the take-over.
		for unit in units
			player.getUnits().remove(unit)

		# Let the planet change hands.
		player.addPlanetOwnership(planet)
		old_player.removePlanetOwnership(planet)

