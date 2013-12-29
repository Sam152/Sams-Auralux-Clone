###
A player who has control over planets and units.
###
class window.Player

	# How fast should units spawn.
	@UNIT_GENERATION_SPEED: 10

	constructor: () ->
		# The planets this player currently controls.
		@planets = []
		# The units this player has control over.
		@units = []
		@tick_count = 0
	
	# Create a random group of planets.
	createRandomPlanets: (number) ->
		max_radius = Planet.MAX_PLANET_RADIUS
		for i in [0..number]
			@planets.push(new Planet(
				Random.integer(max_radius, window.innerWidth - max_radius),
				Random.integer(max_radius, window.innerHeight - max_radius),
				Random.integer(Planet.MIN_PLANET_RADIUS, max_radius))
			)

	tick: ->
		@tick_count++
		
		# Ensure our planets and units are ticked.
		_.invoke(@planets, 'tick')
		_.invoke(@units, 'tick')
		
		# Ensure units are created when required.
		@generatePlanetUnits()

	# Generate units for each of the planets we control.
	generatePlanetUnits: ->

		if @tick_count % Player.UNIT_GENERATION_SPEED != 0
			return

		for planet in @planets
			@units.push(planet.spawnUnit())
