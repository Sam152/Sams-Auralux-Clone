class window.Input
	
	# Allow people to bind to mousewheel events.
	@captureMousewheel: (handleScroll, self) ->
		context.canvas.addEventListener('mousewheel', (event) ->
			handleScroll.call(self, event)
			# Prevent "over-scroll" on webkit devices.
			event.preventDefault()
			return false
		)

	# Capture mouse movement.
	@captureMousemove: (handleMove, self) ->
		# Attach to mouse movements.
		context.canvas.addEventListener('mousemove', (event) ->
			handleMove.call(self, event)
		, false)

	# Capture dragging.
	@captureDrag: (handleDrag, self) ->

		$(context.canvas).bind('mousedown', (downEvent) ->
			$(context.canvas).bind('mousemove.tmpevent', (moveEvent) ->
				handleDrag.call(self, event)
			)
		)
		
		$(context.canvas).bind('mouseup', ->
			$(context.canvas).unbind('.tmpevent')
		)

	@captureMouseDown: (handleDown, self) ->
		$(context.canvas).bind('mousedown', (event) ->
			handleDown.call(self, event)
		)
