class window.Menu
	constructor: ->
		console.log('Menu created')

	tick: (state_controls) ->
		console.log('Menu tick')

		state_controls(
			(state, states) -> 
				state.execute = states.IN_GAME
		)
