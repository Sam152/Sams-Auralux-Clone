class window.Unit

	@UNIT_SPEED: 7
	@UNIT_WIDTH: 5
	@UNIT_COUNTER: 0

	constructor: (x, y, @color) ->
		# Ensure each unit has a unique ID.
		Unit.UNIT_COUNTER++

		@active = false

		@position = new Circle(x, y, Unit.UNIT_WIDTH)
		@unit_destroyed = false
		@id = Unit.UNIT_COUNTER
		
	setDestination: (point) ->
		@position.moveTowards(point, Unit.UNIT_SPEED)

	tick: ->
		@position.tick()
		@drawUnit()

	setActive: (status) ->
		@active = status

	isActive: ->
		return @active

	getPosition: ->
		return @position

	getId: ->
		return @id

	drawUnit: ->
		pos = @getPosition()
		ctx = context.get2d()
		ctx.save()
		ctx.globalAlpha = 0.5
		ctx.beginPath();
		ctx.fillStyle = @color.hex
		ctx.strokeStyle = if @isActive() then '#000' else 'transparent'
		ctx.arc(pos.getX(), pos.getY(), pos.getR(), 0, Math.PI * 2)
		ctx.closePath()
		ctx.fill()
		ctx.stroke()
		ctx.restore()
