###
Refactor this whole thing into a class and stop using statics.
###
class window.CollisionsGrid extends Collisions

	@spacial_grid_items = []
	@grid_size: 16

	@reset: ->
		@grid = {}

	@insertUnitGroup: (units) ->
		for unit in units
			CollisionsGrid.insertIntoGrid(unit)

	# Inset a bunch of units into a grid.
	@insertIntoGrid: (unit) ->
		position = unit.getPosition()
		cell = Math.floor(position.getX() / @grid_size) + 'x' + Math.floor(position.getY() / @grid_size)
		@grid[cell] = @grid[cell] || []
		@grid[cell].push(unit)
			
	# Check the grid for matching units.
	@checkGrid: ->
		for cell of @grid
			for unit in cell
				# Find the balance of which units belong to who. If 10 belong to 
				# A and 5 to B, player A should be left with 5 and B 0.
				# Maybe just keep the ownership balance in another grid?

	addItem: (@unit) ->
		position = @unit.getPosition()
