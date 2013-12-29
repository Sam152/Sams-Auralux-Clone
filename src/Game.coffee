class window.Game
	constructor: (@context) ->
		
		@circles = [
			new Circle(600, 131, 200),
			new Circle(540, 392, 140),
			new Circle(100, 221, 55),
			new Circle(811, 356, 120),
		]

	tick: (state_controls) ->
		_.invoke(@circles, 'renderWireframe', @context)

