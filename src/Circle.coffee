class window.Circle extends Position
	constructor: (x, y, @r) ->
		super x, y

	renderWireframe: () ->
		ctx = context
		# Render the circles radius.
		ctx.setColor('#F00')
		ctx.setLineWidth(1)
		ctx.get2d().beginPath();
		ctx.get2d().moveTo(@x, @y);
		ctx.get2d().lineTo(@x + @r, @y);
		ctx.get2d().stroke();
		# Render a point for the center.
		ctx.setColor('#070')
		ctx.get2d().fillRect(@x - 1.5, @y - 1.5, 3, 3)
		# Draw the actual circle.
		ctx.get2d().beginPath();
		ctx.get2d().fillStyle = 'transparent'
		ctx.get2d().strokeStyle = '#00F'
		ctx.get2d().arc(@x, @y, @r, 0, Math.PI * 2); 
		ctx.get2d().closePath();
		ctx.get2d().stroke();

	intersectsWith: (circle) ->
		return @distanceFrom(circle) <= circle.r + @r

	getR: ->
		return @r

	setR: (r) ->
		@r = r
