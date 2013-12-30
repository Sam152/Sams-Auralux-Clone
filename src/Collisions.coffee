###
Handle collisions and conflicts between units.
###
class window.Collisions

	# How often (based on ticks) collisions should be checked/
	@COLLISION_CHECKING_SCHEDULE: 6

	# Resolve colliding units between an array of players.
	@resolveCollisions: (combat_players) ->
		
		matchup_number = 0
		for player, outer_checked in combat_players
			for compare_player, inner_checked in combat_players
				# Ensure we only check each player against eachother once.
				if compare_player == player || outer_checked > inner_checked
					continue

				if ticks % Collisions.COLLISION_CHECKING_SCHEDULE == matchup_number
					# Check the units of the two players we have elected to compare.
					Collisions.compareUnits(player, compare_player)

				matchup_number++


	# Compare the units provided by two players.
	@compareUnits: (player, compare_player) ->

		compare_to_units = compare_player.getUnits()
		units = player.getUnits()

		for unit, outer_unit_checked in units.getAll()
			for compare_unit, inner_unit_checked in compare_to_units.getAll()

				# When we consider there a collision between some units.
				if unit.getPosition().distanceFrom(compare_unit.getPosition()) < Game.UNIT_COLLISION_SENSITIVITY

					# Wipe them off the face of the earth.
					units.remove(unit)
					compare_to_units.remove(compare_unit)
					
					# We need to break two loops to stop a single unit
					# from wiping out multiple other units.
					break
