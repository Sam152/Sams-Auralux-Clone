###
A container for some DOM elements and the 2d context.
###
class window.Context
	
	constructor: (@canvas) -> 

		@context2d = @canvas.getContext('2d')
		
		@$document = $(document)
		@$body = $('body')

		@setLineWidth(1)
		@matchClientWidth()

		# Ensure that when resizing, things stay the same size.
		self = @
		$(window).bind('resize', ->
			self.matchClientWidth.call(self)
		)

	matchClientWidth: ->
		@canvas.width = @canvas.clientWidth
		@canvas.height = @canvas.clientHeight

	get2d: ->
		return @context2d

	getCanvas: ->
		return @canvas

	getHeight: ->
		return @canvas.height
		
	getWidth: ->
		return @canvas.width

	setColor: (color) ->
		@get2d().fillStyle = color
		@get2d().strokeStyle = color

	setLineWidth: (width) ->
		@get2d().lineWidth = width

	clearScreen: ->
		@get2d().clearRect(0, 0, @canvas.width, @canvas.height)
