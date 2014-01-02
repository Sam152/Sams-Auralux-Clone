###
Handle collisions and conflicts between units.
###
class window.Collisions

	# How often (based on ticks) collisions should be checked for player
	# matchups. This could be replaced with something that works out the
	# combinations of players because ultimately that is the optimal number.
	@PLAYER_COLLISION_CHECKING_SCHEDULE: 6

	# How many ticks to split unit checking into.
	@UNIT_COLLISION_CHECKING_SCHEDULE: 5

	# How close should units be before they collide. Until/unless some sort
	# of "attraction" is implemented, this needs to be set quite high to keep
	# units colliding easily.
	@UNIT_COLLISION_SENSITIVITY: 40

	# Take an array of players and vs them against eachother by calling the
	# passed func. This ensures that each player is only matched up once. This
	# may need a better place to live.
	@playerMatchup: (players, func, self) ->
		for player, outer_checked in players
			for compare_player, inner_checked in players
				# Ensure we only check each player against eachother once.
				if compare_player == player || outer_checked > inner_checked
					continue

				func.call(self, player, compare_player)


	# Resolve colliding units between an array of players.
	@resolveCollisions: (combat_players) ->
		matchup_number = 0
		Collisions.playerMatchup(combat_players, (player, compare_player) ->
			# Instead of using Schedule, we can stagger the collision
			# detection per player matchup in order to put less stress on
			# a specific tick.
			if ticks % Collisions.PLAYER_COLLISION_CHECKING_SCHEDULE == matchup_number || matchup_number > Collisions.PLAYER_COLLISION_CHECKING_SCHEDULE

				compare_to_units = compare_player.getUnits()
				units = player.getUnits()
				# Check the units of the two players we have elected to compare.
				Collisions.compareUnits(units, compare_to_units)

			matchup_number++
		, @)


	# Compare the units provided by two players.
	@compareUnits: (units, compare_to_units) ->

		# Compare each units position with each other unit.
		for unit, outer_checked in units.getAll()
			for compare_unit, inner_checked in compare_to_units.getAll()

				# When we consider there a collision between some units.
				if unit.getPosition().distanceFrom(compare_unit.getPosition()) < Collisions.UNIT_COLLISION_SENSITIVITY

					# Wipe them off the face of the earth.
					units.remove(unit)
					compare_to_units.remove(compare_unit)
					
					# We need to break two loops to stop a single unit
					# from wiping out multiple other units.
					break
