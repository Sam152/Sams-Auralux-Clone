###
A simple DOM based menu for start a game and possibly selecting levels.
###
class window.Menu
	constructor: (@context) ->		
		@menu_exists_in_dom = false

	# Since we are using the DOM (and events) to render and continue the state
	# we don't need to have a tick, however it is here to be consistent with
	# other states. We do need to check if the menu 
	tick: (@state_controls) ->		
		if @menu_exists_in_dom == false
			@createMenu()

	createMenu: ->

		menu_items = [
			{
				label : 'Start Game',
				callMethod : 'startGame'
			}
		]

		@menu_element = $('<div id="menu"></div>')
		
		@context.$body.append(@menu_element)
		@menu_exists_in_dom = true

		# When the menu is clicked, change states.
		self = @
		@menu_element.click(-> self.startGame.call(self))

	destroyMenu: ->
		@menu_element.remove()
		@menu_exists_in_dom = false

	startGame: ->
		@destroyMenu();
		@state_controls(
			(state, states) -> 
				state.execute = states.IN_GAME
		)
