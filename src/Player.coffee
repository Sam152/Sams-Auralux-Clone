###
A player who has control over planets and units.
###
class window.Player

	# How fast should units spawn.
	@UNIT_GENERATION_SPEED: 3

	constructor: (@color) ->
		# The planets this player currently controls.
		@planets = []
		# The units this player has control over.
		@units = new UnitCollection()


	# Create a random group of planets.
	createRandomPlanets: (number) ->

		edge_buffer = Planet.MAX_PLANET_RADIUS + Planet.UNIT_DISTANCE_FROM_PLANET + Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE

		for i in [0..number]
			@planets.push(new Planet(
				Random.integer(edge_buffer, window.innerWidth - edge_buffer),
				Random.integer(edge_buffer, window.innerHeight - edge_buffer),
				Random.integer(Planet.MIN_PLANET_RADIUS, Planet.MAX_PLANET_RADIUS),
				@color
			))

	tick: ->
		# Ensure our planets and units are ticked.
		_.invoke(@planets, 'tick')
		@units.tickAll()

		# Ensure units are created when required.
		@generatePlanetUnits()
		_.invoke(@planets, 'drawPlanet')

	# Generate units for each of the planets we control.
	generatePlanetUnits: ->
		if ticks % Player.UNIT_GENERATION_SPEED != 0
			return

		for planet in @planets
			@units.add(planet.spawnUnit())

	getUnits: ->
		return @units

	getPlanets: ->
		return @planets

	getColor: ->
		return @color

	# Tell this player that a planet no longer belongs to them.
	removePlanetOwnership: (planet) ->
		for planet_candidate, i in @planets
			if planet_candidate == planet
				delete @planets[i]
				@planets = @planets.filter( (n) -> return n)
				break

	# Bring a new planet into the circle of trust. Pay special attention to what
	# happens in the constructor of Planet, because this function needs to
	# replicate a lot of the player specific setup logic.
	addPlanetOwnership: (planet) ->
		planet.setColor(@getColor())
		@planets.push(planet)

