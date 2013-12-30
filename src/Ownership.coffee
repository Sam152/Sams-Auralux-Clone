###
Manage who owns what.
###
class window.Ownership

	@OWNERSHIP_CHECK_FREQUENCY: 20

	# Check if any planets need to transfer ownership.
	@checkPlanetOwnership: (players, neutral_player) ->

		# Run expensive operations infrequently.
		Schedule.runEvery(Ownership.OWNERSHIP_CHECK_FREQUENCY, ->
			Collisions.playerMatchup(players, (player, compare_player) -> 

				# No need to check if the neutral players units are concouring
				# the world.
				if compare_player == neutral_player
					return

				# Get the units we will be testing.
				opponents_units = compare_player.getUnits()

				for planet in player.getPlanets()

			,@)
		,@)
