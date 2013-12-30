class window.Unit

	@UNIT_SPEED: 5
	@UNIT_WIDTH: 5
	@UNIT_COUNTER: 0

	constructor: (x, y) ->
		# Ensure each unit has a unique ID.
		Unit.UNIT_COUNTER++

		@position = new Circle(x, y, Unit.UNIT_WIDTH)
		@unit_destroyed = false
		@id = Unit.UNIT_COUNTER
		
	setDestination: (point) ->
		@position.moveTowards(point, Unit.UNIT_SPEED)

	tick: ->
		@position.tick()
		@position.renderWireframe()

	getPosition: ->
		return @position

	getId: ->
		return @id
