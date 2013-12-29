###
A planet that produces units.
###
class window.Planet

	@MIN_PLANET_RADIUS: 10
	@MAX_PLANET_RADIUS: 30

	constructor: (x, y, size) ->
		@position = new Circle(x, y, size)

	tick: ->
		@position.renderWireframe()

	getPosition: ->
		return @position

	# Create a new unit which is positioned outside of the planet.
	spawnUnit: ->
		# Generate a unit vector in a random direction.
		random_unit_vector = (new Position(Random.integer(-500, 500), Random.integer(-500, 500))).getUnitVector()

		# Make it the size of the planet.
		random_offset = random_unit_vector.clone()
		random_offset.multiply(@position.getR())

		# Make another one the size of the planet, plus some
		random_offset_destination = random_unit_vector.clone()
		random_offset_destination.multiply(@position.getR() + 20)

		random_offset.add(@position)
		random_offset_destination.add(@position)

		unit = new Unit(random_offset.getX(), random_offset.getY())
		unit.setDestination(random_offset_destination)

		return unit
