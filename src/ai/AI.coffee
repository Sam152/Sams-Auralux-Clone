###
Some behaviour for the player to play against. 
###
class window.AI

	constructor: (@player, @other_players, @neutral_player) ->

		# Some stats related to how often our AI should do certain things.
		@defence = 20
		@attack = 100
		@expand = 20

		# Get some general stats about the player to use.
		@updateGeneralStats()

		# Keep track of all of the planets.
		@updatePlanetStats()

		# How many additional units should we send to a planet when populating it.
		@expansion_unit_buffer = 5

		# How many additional units should we send to defend a planet takeover.
		# This buffer is handy because a planet produces units while we are in
		# transit.
		@attack_unit_buffer = 100

	tick: ->

		# Should we be expanding more than we should be attacking?
		favour_expansion = @stats.NEUTRAL_PLANETS_LEFT > @stats.MY_PLANETS

		Schedule.runEvery(10, ->
			@updateGeneralStats()
		,@)

		Schedule.runEvery(30, ->
			@updatePlanetStats()
		,@)

		Schedule.runEvery(@expand, ->
			@makeExpansionMove()
		,@)

		Schedule.runEvery(@attack, ->
			# Favor expansion in the early days of the game.
			if favour_expansion && Random.integer(0, 3) != 0
				return
			@makeAttackMove()
		,@)

	# Keep all of the planet statistics up to date.
	updatePlanetStats: () ->
		@planets = []
		for planet in @player.getPlanets()
			stats_planet = {}
			stats_planet.nearest_occupied = @getNearestPlanet(planet, 1)
			stats_planet.nearest_unoccupied = @getNearestPlanet(planet, 2)
			stats_planet.nearest_friendly = @getNearestPlanet(planet, 3)
			stats_planet.nearby_units = @getNearbyUnits(planet, @player)
			stats_planet.planet = planet
			@planets.push(stats_planet)

	# Calculate general stats about this players situation.
	updateGeneralStats: () ->
		@stats = {
			NEUTRAL_PLANETS_LEFT : @neutral_player.getPlanets().length,
			MY_PLANETS : @player.getPlanets().length,
		}

	# Get the nearest planet to another planet.
	# occupied = 1
	# unoccupied = 2
	# own = 3
	# @todo, look at breaking this into a few more useful methods.
	getNearestPlanet: (planet, type) ->
		
		min_distance = false
		nearest_planet = false
		owner = false

		candidate_players = [] 
		
		# If we are only looking for unoccupied planets.
		if type == 2
			candidate_players = [@neutral_player]

		# If we are only looking for occupied planets.
		if type == 1
			candidate_players = _.filter(@other_players, (player) ->
				return player != @neutral_player
			,@)

		# If we only want to find our own nearby neighbours.
		if type == 3
			candidate_players = [@player]

		for other_player, n in candidate_players
			other_planets = other_player.getPlanets()
			for other_planet, i in other_planets

				# In the case of searching for our own planets, don't allow a
				# planet to be clostest to itself.
				if other_planet == planet
					continue

				distance = other_planet.getPosition().distanceFrom(planet.getPosition())

				if min_distance == false || distance < min_distance
					min_distance = distance
					nearest_planet = i
					owner = n

		# Keeping track of references in for loops is tricky, everything needs to
		# be done by index because the for loop overrides the references we make.
		# @todo, see if there is a better way of doing this.
		winning_player = candidate_players[owner] || false
		winning_planet = if winning_player then winning_player.getPlanets()[nearest_planet] else false

		return {
			'planet' : winning_planet,
			'player' : winning_player,
		}

	# Get units close to a planet, belonging to a player.
	getNearbyUnits: (planet, player) ->
		nearbyUnits = new UnitCollection()
		# The max distance a unit can naturally fall from a planet.
		max_distance = planet.getPosition().getR() + Planet.MAX_PLANET_RADIUS + Planet.UNIT_DISTANCE_FROM_PLANET + Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE
		for unit in player.getUnits().getAll() when unit.getPosition().distanceFrom(planet.getPosition()) <= max_distance
			nearbyUnits.add(unit)
		return nearbyUnits

	# Expand into other areas of the map.
	makeExpansionMove: ->

		# We can't expand if there are no planets there to do so.
		if @neutral_player.getPlanets().length == 0
			return
		# For all the planets capeable of fully populating a planet.
		for planet in @planets when planet.nearby_units.count() > Ownership.UNIT_COVERAGE_REQUIREMENT + @expansion_unit_buffer
			# If we don't have any unoccupied planets we can't occupy them.			
			if false == planet.nearest_unoccupied
				break
			planet.nearby_units.sendTo(planet.nearest_unoccupied.planet.getPosition())


	# Attack nearby players when we are capeable.
	makeAttackMove: ->
		for planet in @planets

			victim = planet.nearest_occupied

			if false == victim.planet
				continue

			total_defence = @getNearbyUnits(victim.planet, victim.player).count()

			# See how many units we need to take over the target planet.
			required_units = total_defence + @attack_unit_buffer + Ownership.UNIT_COVERAGE_REQUIREMENT

			# Don't require too many units, because some of our other planets are
			# probably also going to be attacking the same thing.
			required_units = required_units / Math.pow(@player.getPlanets().length, 2)

			# See if we are capeable of a planet takeover.
			if planet.nearby_units.count() >= required_units
				planet.nearby_units.sendTo(victim.planet.getPosition())

	makeDefenceMove: ->
