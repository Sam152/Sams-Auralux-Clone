###
A way of storing collections of units. Prevents simple things like duplicate
units being added to the same collection.
@todo, perhaps investigate a generic collection which applies methods in bulk
to sub items instead of manually writing collections to pass through commands.
Specific commands could be overriden by parent elements.
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
		for key, unit of @units
			unit_array.push(unit)
		return unit_array

	# Get how many units are currently in our collection.
	count: ->
		return @getAll().length

	# Get the unique key that identifies a unit.
	getObjectKey: (unit) ->
		return "id-#{unit.getId()}"

	# Remove all units from a collection.
	clearAll: ->
		self = @
		$.each(@getAll(), (i, unit) ->
			self.remove(unit)
		)

	# Send the collection to a point.
	sendTo: (position) ->
		position = position.clone()
		self = @
		
		for unit in @getAll()

			move_to = position.clone()
			move_to.add(
				new Position(
					Random.integer(-UnitCollection.SEND_TO_SPREAD_AMOUNT, UnitCollection.SEND_TO_SPREAD_AMOUNT),
					Random.integer(-UnitCollection.SEND_TO_SPREAD_AMOUNT, UnitCollection.SEND_TO_SPREAD_AMOUNT)
				)
			)

			unit.setDestination(move_to)

	tickAll: ->
		for unit in @getAll()
			unit.tick()

	# Set a group of units as being active or inactive.
	setActive: (status) ->
		for unit in @getAll()
			unit.setActive(status)
