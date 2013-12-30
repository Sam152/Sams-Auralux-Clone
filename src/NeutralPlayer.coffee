###
A player which is not involed in the game. This is currently used so there can
be vacant planets. Vacant planets are vacant because the "generatePlanetUnits"
function has been overriden to cancel any production of units. Otherwise, this
player is like any other, making calculations and comparisions about who owns
what more generic without special cases about "owned" and "unowned".
###
class window.NeutralPlayer extends Player
	generatePlanetUnits: ->
