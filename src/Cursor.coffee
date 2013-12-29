###
Allow people to provide input into the game-space via a cursor.
###
class window.Cursor

	# The speed at which the selection radius changes.
	@SELECTION_RADIUS_CHANGE_SPEED: 15

	# The bounds of our selection radius.
	@MAX_SELECTION_RADIUS: 300
	@MIN_SELECTION_RADIUS: 50

	# How much delta a mouse needs to be scrolling before a direction is registered.
	@SCROLL_SENSITIVITY: 3

	constructor: ->
		self = @
		@selection_radius = 50

		@position = new Circle(-100, -100, Cursor.MIN_SELECTION_RADIUS)

		# Attach to mouse wheel movements.
		context.canvas.addEventListener('mousewheel', (event) ->
    		self.handleScroll.call(self, event)
    		# Prevent "over-scroll" on webkit devices.
    		event.preventDefault()
    		return false
		, false)

		# Attach to mouse movements.
		context.canvas.addEventListener('mousemove', (event) ->
			self.handleMove.call(self, event)
		, false)

	# Handle scroll events passed to the space.
	handleScroll: (e) ->
		sensitivity = Cursor.SCROLL_SENSITIVITY
		# Calculate which direction the user is scrolling.
		direction = if e.deltaY > sensitivity then 1 else if e.deltaY < -sensitivity then -1 else 0
		@setSelectionRadius(@selection_radius + (direction * Cursor.SELECTION_RADIUS_CHANGE_SPEED))

	# Handle when the user moves the mouse.
	handleMove: (e) ->
		@position.setX(e.pageX)
		@position.setY(e.pageY)

	# Set the selection radius and check the bounds.
	setSelectionRadius: (radius) ->
		# Ensure we are within the bounds of the selection radius.
		radius = if radius > Cursor.MAX_SELECTION_RADIUS then Cursor.MAX_SELECTION_RADIUS else radius
		radius = if radius < Cursor.MIN_SELECTION_RADIUS then Cursor.MIN_SELECTION_RADIUS else radius
		@selection_radius = radius
		@position.setR(@selection_radius)

	tick: ->
		@position.renderWireframe()
