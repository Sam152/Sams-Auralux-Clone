###
Create a game based on a map.
###
class window.CircleGame extends Game

	# Load a map from ./maps to setup the game.
	setupGameplay: (map) ->
		
		diameter = Math.min(window.innerHeight, window.innerWidth) - 50
		radius = diameter / 2
		center = new Circle(window.innerWidth / 2, window.innerHeight / 2, radius)

		@neutral_player = new NeutralPlayer(Game.PLAYER_COLORS.BLACK)
		@human_player = new Player(Game.PLAYER_COLORS.BLUE)
		red_player = new Player(Game.PLAYER_COLORS.RED)
		green_player = new Player(Game.PLAYER_COLORS.GREEN)

		@players = [
			@neutral_player,
			red_player,
			@human_player,
			green_player,
		]
		@combat_players = [
			red_player,
			@human_player,
			green_player,
		]

		# Create a planet in the middle of the screen.
		@neutral_player.createPlanet(center.getX(), center.getY(), 50)

		planets_each = 4

		# Create a group of planets equally distributed around a circle.
		total_combat_planets = @combat_players.length * planets_each
		segment_size = ((2 * Math.PI) / total_combat_planets)
		for i in [0..total_combat_planets]
			radians = segment_size * i
			player = Math.floor(i / planets_each);
			player = if (i % 2 == 0) then @neutral_player else @combat_players[player % @combat_players.length]
			player.createPlanet(
				radius * Math.sin(radians) + center.getX(),
				radius * Math.cos(radians) + center.getY(),
				20
			)
