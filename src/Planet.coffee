###
A planet that produces units.
###
class window.Planet

	# The bounds for how big a randomly generated planet can be.
	@MIN_PLANET_RADIUS: 20
	@MAX_PLANET_RADIUS: 20

	# The distance a unit falls from the planet.
	@UNIT_DISTANCE_FROM_PLANET: 15

	# The variance of how far a unit falls from a planet
	@UNIT_DISTANCE_FROM_PLANET_VARIANCE: 0

	constructor: (x, y, size, @color) ->
		@position = new Circle(x, y, size)

	tick: ->

	getPosition: ->
		return @position

	getColor: ->
		return @color

	setColor: (color) ->
		@color = color

	# Create a new unit which is positioned outside of the planet.
	spawnUnit: ->
		# Generate a unit vector in a random direction.
		random_unit_vector = Position.randomUnitVector()

		# Make it the size of the planet.
		random_offset = random_unit_vector.clone()

		distance_from_planet = Planet.UNIT_DISTANCE_FROM_PLANET + Random.integer(-Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE, Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE)

		# Make another one the size of the planet, plus some
		random_offset_destination = random_unit_vector.clone()
		random_offset_destination.multiply(@position.getR() + distance_from_planet)

		random_offset.add(@position)
		random_offset_destination.add(@position)

		unit = new Unit(random_offset.getX(), random_offset.getY(), @color)
		unit.setDestination(random_offset_destination)

		return unit

	drawPlanet: ->
		pos = @getPosition()
		ctx = context.get2d()
		ctx.save()
		ctx.globalAlpha = 0.6
		ctx.beginPath();
		ctx.fillStyle = @color.hex
		ctx.strokeStyle = '#000'
		ctx.strokeStyle = '#000'
		ctx.arc(pos.getX(), pos.getY(), pos.getR(), 0, Math.PI * 2)
		ctx.closePath()
		ctx.fill()
		ctx.stroke()
		ctx.restore()
