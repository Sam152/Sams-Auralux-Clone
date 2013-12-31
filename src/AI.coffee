###
Some behaviour for the player to play against. 
###
class window.AI

	constructor: (@player, @other_players, @neutral_player) ->

		# Some stats related to how often our AI should do certain things.
		@defence = 20
		@attack = 20
		@expand = 20

		# Get some general stats about the player to use.
		@updateGeneralStats()

		# Keep track of all of the planets.
		@updatePlanetStats()

	tick: ->

		Schedule.runEvery(80, ->
			@updateGeneralStats()
		,@)

		Schedule.runEvery(30, ->
			@updatePlanetStats()
		,@)

		Schedule.runEvery(@expand, ->
			@makeExpansionMove()
		,@)

	# Keep all of the planet statistics up to date.
	updatePlanetStats: () ->
		@planets = []
		for planet in @player.getPlanets()
			stats_planet = {}
			stats_planet.nearest_occupied = @getNearestPlanet(planet, true)
			stats_planet.nearest_unoccupied = @getNearestPlanet(planet, false)
			stats_planet.nearby_units = @getNearbyUnits(planet)
			stats_planet.planet = planet
			@planets.push(stats_planet)

	# Calculate general stats about this players situation.
	updateGeneralStats: () ->
		@stats = {
			TOTAL_UNITS : 0,
		}

	# Get the nearest planet to another planet.
	getNearestPlanet: (planet, occupied) ->
		
		min_distance = false
		nearest_planet = false

		for other_player in @other_players
			# Check we are only getting either occupied or unoccupied planets.
			if occupied && other_player == @neutral_player
				continue
			if !occupied && other_player != @neutral_player
				continue

			other_planets = other_player.getPlanets()
			for other_planet, i in other_planets
				distance = other_planet.getPosition().distanceFrom(planet.getPosition())

				if min_distance == false || distance < min_distance
					min_distance = distance
					nearest_planet = i

		return other_planets[nearest_planet]

	# Get total units.
	getNearbyUnits: (planet) ->
		nearbyUnits = new UnitCollection()
		# The max distance a unit can naturally fall from a planet.
		max_distance = planet.getPosition().getR() + Planet.MAX_PLANET_RADIUS + Planet.UNIT_DISTANCE_FROM_PLANET + Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE
		for unit in @player.getUnits().getAll() when unit.getPosition().distanceFrom(planet.getPosition()) <= max_distance
			nearbyUnits.add(unit)
		return nearbyUnits

	# Expand into other areas of the map.
	makeExpansionMove: ->

		# We can't expand if there are no planets there to do so.
		if @neutral_player.getPlanets().length == 0
			return

		for planet in @planets when planet.nearby_units.count() > Ownership.UNIT_COVERAGE_REQUIREMENT
			planet.nearby_units.sendTo(planet.nearest_unoccupied.getPosition())

		console.log(planet)


	makeAttackMove: ->

	makeDefenceMove: ->
