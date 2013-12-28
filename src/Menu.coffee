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
		self = @

		# Some menu items to render.
		menu_items = {
			startGame : {
				label : 'Start Game',
			}
		}

		# Create our parent element.
		@menu_element = $('<div/>', {'id' : 'menu'})

		# For all of our menu items, keyed by the method we want to execute.
		for method, display_info of menu_items
			# Create a child menu item.
			menu_item = $('<div/>', {
				'class' : 'menu-item'
			})
			# Set the text.
			.text(display_info.label)
			# Trigger the relevant method when clicked.
			.click(-> self[method].call(self))
			# And add it to our menu.
			.appendTo(@menu_element)

		# Add our fully built menu to the DOM.
		@context.$body.append(@menu_element)
		@menu_exists_in_dom = true

	destroyMenu: ->
		@menu_element.remove()
		@menu_exists_in_dom = false

	startGame: ->
		@destroyMenu();
		@state_controls(
			(state, states) -> 
				state.execute = states.IN_GAME
		)
