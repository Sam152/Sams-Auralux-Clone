###
A player who has control over planets and units.
###
class window.Player

	# How fast should units spawn.
	@UNIT_GENERATION_SPEED: 10

	constructor: (@color) ->
		# The planets this player currently controls.
		@planets = []
		# The units this player has control over.
		@units = new UnitCollection()
		@tick_count = 0

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
		@tick_count++
		
		# Ensure our planets and units are ticked.
		_.invoke(@planets, 'tick')
		@units.tickAll()

		# Ensure units are created when required.
		@generatePlanetUnits()

		@drawPlanets()

	# Generate units for each of the planets we control.
	generatePlanetUnits: ->
		if @tick_count % Player.UNIT_GENERATION_SPEED != 0
			return

		for planet in @planets
			@units.add(planet.spawnUnit())

	drawPlanets: ->
		for planet in @planets

			pos = planet.getPosition()
			ctx = context.get2d()
			ctx.save()
			ctx.globalAlpha = 0.5
			ctx.beginPath();
			ctx.fillStyle = @color.hex
			ctx.strokeStyle = '#00F'
			ctx.arc(pos.getX(), pos.getY(), pos.getR(), 0, Math.PI * 2); 
			ctx.closePath();
			ctx.fill();
			ctx.stroke();
			ctx.restore()

	getUnits: ->
		return @units
