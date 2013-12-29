class window.Unit

	@UNIT_SPEED: 1

	constructor: (x, y) ->
		@position = new Circle(x, y, 2)

	setDestination: (point) ->
		@position.moveTowards(point, Unit.UNIT_SPEED)

	tick: ->
		@position.tick()
		@position.renderWireframe()
