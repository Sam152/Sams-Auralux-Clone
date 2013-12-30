###
A planet that produces units.
###
class window.Planet

	# The bounds for how big a randomly generated planet can be.
	@MIN_PLANET_RADIUS: 10
	@MAX_PLANET_RADIUS: 30

	# The distance a unit falls from the planet.
	@UNIT_DISTANCE_FROM_PLANET: 10

	# The variance of how far a unit falls from a planet
	@UNIT_DISTANCE_FROM_PLANET_VARIANCE: 20

	constructor: (x, y, size) ->
		@position = new Circle(x, y, size)

	tick: ->
		@position.renderWireframe()

	getPosition: ->
		return @position

	# Create a new unit which is positioned outside of the planet.
	spawnUnit: ->
		# Generate a unit vector in a random direction.
		random_unit_vector = Position.randomUnitVector()

		# Make it the size of the planet.
		random_offset = random_unit_vector.clone()
		random_offset.multiply(@position.getR())

		distance_from_planet = Planet.UNIT_DISTANCE_FROM_PLANET + Random.integer(-Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE, Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE)

		# Make another one the size of the planet, plus some
		random_offset_destination = random_unit_vector.clone()
		random_offset_destination.multiply(@position.getR() + distance_from_planet)

		random_offset.add(@position)
		random_offset_destination.add(@position)

		unit = new Unit(random_offset.getX(), random_offset.getY())
		unit.setDestination(random_offset_destination)

		return unit
