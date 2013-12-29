class window.Unit

	@UNIT_SPEED: 1
	@UNIT_WIDTH: 5

	constructor: (x, y) ->
		@position = new Circle(x, y, Unit.UNIT_WIDTH)

	setDestination: (point) ->
		@position.moveTowards(point, Unit.UNIT_SPEED)

	tick: ->
		@position.tick()
		@position.renderWireframe()
