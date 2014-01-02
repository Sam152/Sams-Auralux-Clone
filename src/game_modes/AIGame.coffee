###
Create a completely random game.
###
class window.AIGame extends Game

	setupGameplay: () ->
		
		@neutral_player = new NeutralPlayer(Game.PLAYER_COLORS.BLACK)
		@human_player = new Player(Game.PLAYER_COLORS.BLUE)
		
		red_player = new Player(Game.PLAYER_COLORS.RED)
		green_player = new Player(Game.PLAYER_COLORS.GREEN)
		orange_player = new Player(Game.PLAYER_COLORS.ORANGE)
		blue_player = new Player(Game.PLAYER_COLORS.BLUE)

		@players = [
			@neutral_player,
			red_player,
			green_player,
			blue_player,
			orange_player,
		]

		@combat_players = [
			red_player,
			green_player,
			blue_player,
			orange_player,
		]

		# Create some randomly laid out planets for each of the players.
		_.invoke(@combat_players, 'createRandomPlanets', 0)

		# Set a few random neutral planets.
		@neutral_player.createRandomPlanets(20)
