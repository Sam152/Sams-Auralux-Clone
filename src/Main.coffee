###
The entry point for our game.
###
class window.Main
	start: (@canvas) ->
		
		# The high level state of the game and the functions that execute them.
		# todo, consider using coffee-machine to replace custom rolled crap.
		states = {
			IN_MENU : ->
			IN_GAME : ->
			GAME_OVER : ->
		}

		state = states.IN_MENU

		# Start a ticker at 30fps.
		ticker = new Ticker({
			tick_function: () ->
				state()
				console.log('test')
			ticks_per_second : 25
		}).start()
