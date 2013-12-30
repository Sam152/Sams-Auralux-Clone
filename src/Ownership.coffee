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
				console.log('a')
			,@)
		,@)
