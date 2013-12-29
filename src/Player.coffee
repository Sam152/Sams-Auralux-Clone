###
A player who has control over planets and units.
###
class window.Player
	constructor: () ->
		@planets = []
		@createRandomPlanets(5)
	
	createRandomPlanets: (number) ->
		# for i in [0..number]
		# 	alert(number)

	tick: ->
		# console.log('Player ticking')