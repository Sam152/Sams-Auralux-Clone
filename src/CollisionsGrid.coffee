###
Refactor this whole thing into a class and stop using statics.
http://cg.informatik.uni-freiburg.de/course_notes/sim_08_sp.pdf
###
class window.CollisionsGrid extends Collisions

	# Compare a set of units using a UniformGrid.
	@compareUnits: (units, compare_units, player, compare_player) ->

		@grid_size = 100

		grid = new UniformGrid(@grid_size)
		compare_grid = new UniformGrid(@grid_size)

		# Create and populate a grid for our own units.
		for unit in units.getAll()
			grid.add(unit.getPosition(), unit)

		# Create and populate a grid for our opponents units.
		for unit in compare_units.getAll()
			compare_grid.add(unit.getPosition(), unit)

		# Loop over our grid.
		for key, cell of grid.getItems()
			# And get the opponents corresponding cell.
			opponent_cell = compare_grid.getCell(key)
			if opponent_cell == false
				continue

			kill_units = Math.min(opponent_cell.length, cell.length)

			for i in [0..kill_units-1]
				units.remove(cell[i])
				compare_units.remove(opponent_cell[i])
