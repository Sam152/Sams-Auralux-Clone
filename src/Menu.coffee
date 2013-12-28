###
A simple DOM based menu for start a game and possibly selecting levels.
###
class window.Menu
	constructor: (@context) ->		
		@menu_exists_in_dom = false

	# Since we are using the DOM (and events) to render and continue the state
	# we don't need to have a tick, however it is here to be consistent with
	# other states. We do need to check if the menu exist in the DOM however.
	tick: (@state_controls) ->		
		if @menu_exists_in_dom == false
			@createMenu()

	createMenu: ->
		self = @

		# Some menu items to render.
		menu_items = [
			{
				label : 'Start Game',
				method : 'startGame'
			},
			{
				label : 'Read Instructions',
				method : 'showInstructions'
			}
		]

		# Create our parent element.
		@menu_element = $('<div/>', {'id' : 'menu'})

		# For all of our menu items, keyed by the method we want to execute.
		for item_info, i in menu_items
			# Create a child menu item.
			menu_item = $('<div/>', {
				'class' : "menu-item menu-item-#{i}"
			})
			# Set the text.
			.text(item_info.label)
			# Trigger the relevant method when clicked.
			.click(-> console.log(item_info.method))
			# And add it to our menu.
			.appendTo(@menu_element)

			# Need to wrap event information in a closure, see
			# /questions/8909652
			((method) -> 
				menu_item.click( -> self[method].call(self))
			)(item_info.method)

		# Add our fully built menu to the DOM.
		@context.$body.append(@menu_element)
		@menu_exists_in_dom = true

	destroyMenu: ->
		@menu_element.remove()
		@menu_exists_in_dom = false

	showInstructions: ->
		console.log('@notimplemented')

	startGame: ->
		@destroyMenu();
		@state_controls(
			(state, states) -> 
				state.execute = states.IN_GAME
		)
