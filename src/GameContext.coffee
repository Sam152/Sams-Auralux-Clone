class window.GameContext
	
	constructor: (@canvas) -> 

		@context = @canvas.getContext('2d')
		@canvas.width = @canvas.clientWidth
		@canvas.height = @canvas.clientHeight

		@$document = $(document)
		@$body = $('body')

	get2d: ->
		return @context

	getCanvas: ->
		return @canvas;