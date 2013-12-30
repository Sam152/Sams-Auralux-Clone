###
A way of storing collections of units. Prevents simple things like duplicate
units being added to the same collection.
###
class window.UnitCollection

	@SEND_TO_SPREAD_AMOUNT: 20

	constructor: ->
		@units = {}

	# Add a unit to our collection.
	add: (unit) ->
		# A cheap way of ensuring no duplicates make it into the collection.
		@units[@getObjectKey(unit)] = unit

	# Remove a unit from our collection.
	remove: (unit) ->
		delete @units[@getObjectKey(unit)]

	# Get all of the units in an array format.
	getAll: ->
		unit_array = []
		$.each(@units, (i, unit) ->
			unit_array.push(unit)
		)
		return unit_array

	getObjectKey: (unit) ->
		return "id-#{unit.getId()}"

	clearAll: ->
		self = @
		$.each(@getAll(), (i, unit) ->
			self.remove(unit)
		)

	sendTo: (position) ->
		position = position.clone()
		self = @
		$.each(@getAll(), (i, unit) ->

			move_to = position.clone()
			move_to.add(
				new Position(
					Random.integer(-UnitCollection.SEND_TO_SPREAD_AMOUNT, UnitCollection.SEND_TO_SPREAD_AMOUNT),
					Random.integer(-UnitCollection.SEND_TO_SPREAD_AMOUNT, UnitCollection.SEND_TO_SPREAD_AMOUNT)
				)
			)

			unit.setDestination(move_to)
		)

	tickAll: ->
		$.each(@getAll(), (i, unit) ->
			unit.tick()
		)
