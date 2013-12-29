###
A simple representation of a position.
###
class window.Position

	constructor: (@x, @y) ->
		# As a position we can store a destination position, which will allow us
		# to move towards that position.
		@destination_position = false
		@speed = 0

	getCoords: ->
		return {x : @getX(), y : @getY()}

	clone: ->
		return new Position(@x, @y)

	getX: ->
		return @x

	getY: ->
		return @y

	multiply: (n) ->
		@x *= n
		@y *= n

	add: (position) ->
		@x += position.getX()
		@y += position.getY()

	minus: (position) ->
		@x -= position.getX()
		@y -= position.getY()

	distanceFrom: (position) ->
		self = @
		return ((m) ->
			return m.sqrt(m.pow(self.x - position.getX(), 2) + m.pow(self.y - position.getY(), 2))
		)(Math)

	getLength: () ->
		self = @
		return ((m) ->
			return m.sqrt(m.pow(self.getX(), 2) + m.pow(self.getY(), 2))
		)(Math)

	getUnitVector: () ->
		multiplyer = (1 / @getLength())
		if multiplyer == 0
			return new Position(0, 0)
		return new Position(@getX() * multiplyer, @getY() * multiplyer)

	# Move towards a point relative to our canvas and position, not relative to
	# the origin.
	moveTowards: (@destination_position, @speed) ->
		if @destination_position == false
			return

		if @distanceFrom(@destination_position) < @speed
			@destination_position = false
			return

		destination_clone = @destination_position.clone()
		destination_clone.minus(@)

		# Get the unit vector for our destination.
		destination_unit_vector = destination_clone.getUnitVector()

		# Multiply it by our speed.
		destination_unit_vector.multiply(@speed)

		# And add it to our current position.
		@add(destination_unit_vector)

	tick: ->
		@moveTowards(@destination_position, @speed)

	# A static method which generates a random unit vector.
	@randomUnitVector: ->
		granularity = 500
		return (
			new Position(
				Random.integer(-granularity, granularity),
				Random.integer(-granularity, granularity)
			)
		).getUnitVector()
