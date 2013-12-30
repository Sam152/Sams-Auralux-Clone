###
Some behaviour for the player to play against. 
###
class window.AI

	constructor: (@player) ->


	tick: ->

		# Get the number of units this player has.
		runEvery(100, ->
			@numberOfUnits = 100
		)
