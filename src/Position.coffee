###
A simple representation of a position.
###
class window.Position
	constructor: (@x, @y) ->

	getCoords: ->
		return {x : @x, y : @y}

	getX: ->
		return @x

	getY: ->
		return @y

	distanceFrom: (position) ->
		self = @
		return ((m) ->
			return m.sqrt(m.pow(self.x - position.getX(), 2) + m.pow(self.y - position.getY(), 2))
		)(Math)
