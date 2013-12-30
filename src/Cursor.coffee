###
Allow people to provide input into the game-space via a cursor.
###
class window.Cursor

	# The speed at which the selection radius changes.
	@SELECTION_RADIUS_CHANGE_SPEED: 3

	# The bounds of our selection radius.
	@MAX_SELECTION_RADIUS: 300
	@MIN_SELECTION_RADIUS: 50

	# How much delta a mouse needs to be scrolling before a direction is registered.
	@SCROLL_SENSITIVITY: 1

	constructor: (@player) ->
		self = @
		@selection_radius = 50

		@position = new Circle(-100, -100, @selection_radius)

		# Move to this system of capturing inut.
		Input.captureMousewheel(@handleScroll, @)
		Input.captureMousemove(@handleMove, @)

		@handleUnitControls()

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

	getPosition: ->
		return @position

	tick: ->
		@position.renderWireframe()


	# Allow drag selection of units.
	handleUnitControls: ->

		@selected_units = new UnitCollection()

		# Gather all of the units that intersect with the cursor and add them to
		# a unit collection.
		collect_units = ->
			for unit in @player.getUnits().getAll()
				if unit.getPosition().intersectsWith(@getPosition())
					@selected_units.add(unit)

		Input.captureMouseDown( (event) ->
			# If we have right clicked, we are commanding units.
			if event.button == 2
				# Send them to the position they were instructed.
				@selected_units.sendTo(@position)
				# And de-select them.
				@selected_units.clearAll()
			else
				# If we are left clicking, clear our old selection and collect
				# a new one.
				@selected_units.clearAll()
				collect_units.call(@)
		, @)

		# While dragging ensure we are collecting units.
		Input.captureDrag(->
			collect_units.call(@)
		, @)

