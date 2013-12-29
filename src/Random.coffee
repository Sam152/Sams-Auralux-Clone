###
Some random helper functions. 
###
class window.Random
	@integer: (from, to) ->
		return (Math.floor(Math.random() * (to - from + 1)) + from)
