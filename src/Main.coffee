###
The entry point for our game.
###
class window.Main
	start: (canvas) ->

		window.context = new Context(canvas);
		window.ticks = 0

		@frame_rate = 30
		
		menu = new Menu()

		# @todo, Instead of creating a game directly, we could move to a game selection
		# screen instead here.
		game = new RandomGame()
		
		# The high level state of the game and the functions that execute them.
		# todo, consider using coffee-machine or another smarter way of handling
		# state vs custom rolled crap.
		states = {
			IN_MENU : ->
				menu.tick(state_controls)
			IN_GAME : ->
				game.tick(state_controls)
			GAME_OVER : ->
				menu.tick(state_controls)
		}

		state = {execute: states.IN_MENU}
		
		state_controls = (change_func) ->
			change_func(state, states)

		# Start a ticker at 30fps.
		ticker = new Ticker({
			tick_function: () ->
				context.clearScreen()
				state.execute()
				window.ticks++
			ticks_per_second : @frame_rate
		}).start()
		
