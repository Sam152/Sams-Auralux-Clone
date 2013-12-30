###
Create a completely random game.
###
class window.RandomGame extends Game

	setupGameplay: () ->
		
		@neutral_player = new NeutralPlayer(Game.PLAYER_COLORS.BLACK)
		@human_player = new Player(Game.PLAYER_COLORS.BLUE)
		red_player = new Player(Game.PLAYER_COLORS.RED)
		green_player = new Player(Game.PLAYER_COLORS.GREEN)

		@players = [
			@neutral_player,
			red_player,
			green_player,
			@human_player
		]
		@combat_players = [red_player, @human_player, green_player]

		# Create some randomly laid out planets for each of the players.
		_.invoke(@combat_players, 'createRandomPlanets', 0)

		# Set a few random neutral planets.
		@neutral_player.createRandomPlanets(5)
