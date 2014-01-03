class window.UniformGrid

	# Create a grid of a given size.
	constructor: (@size) ->
		@grid_items = {}

	# Add an item to the spacial grid given a position. This assumes the cells
	# are an array and are not being managed with setCell and getCell.
	add: (circle, item) ->

		# half_radius = circle.getR() / 2
		# center_x = circle.getX()
		# center_y = circle.getY()
		# points = [
		# 	[center_x, center_y],
		# 	[center_x - half_radius, center_y - half_radius],
		# 	[center_x - half_radius, center_y + half_radius],
		# 	[center_x + half_radius, center_y - half_radius],
		# 	[center_x + half_radius, center_y + half_radius],
		# ]
		# inserted = []
		# for point in points
		# 	key = @getKey(point[0], point[1])
		# 	if key in inserted
		# 		continue
		# 	inserted.push(key)
		# 	@addToCell(key, item)

		key = @getKey(circle.getX(), circle.getY())
		@addToCell(key, item)
		
	# Add an item to a cell in the grid.
	addToCell: (cell, item) ->
		@grid_items[cell] = @grid_items[cell] || []
		@grid_items[cell].push(item)

	# Get the value out of a cell.
	getCell: (cell) ->
		return @grid_items[cell] || false

	# Get a cell name based on a position.
	getKey: (x, y) ->
		return Math.floor(x / @size) + 'x' + Math.floor(y / @size)
		
	# Reset the grid back to nothing.
	reset: ->
		@grid_items = {}

	# Get all the items in a grid.
	getItems: ->
		return @grid_items
