// Generated by CoffeeScript 1.6.3
/*
The primary class for our overarching logic.
*/


(function() {
  window.Game = (function() {
    Game.PLAYER_COLORS = {
      RED: {
        hex: '#F00',
        label: 'red'
      },
      GREEN: {
        hex: '#0F0',
        label: 'green'
      },
      BLUE: {
        hex: '#0a7eaa',
        label: 'blue'
      },
      ORANGE: {
        hex: '#707',
        label: 'orange'
      },
      BLACK: {
        hex: '#999',
        label: 'black'
      }
    };

    function Game() {
      this.setupGameplay();
      this.createAI();
      this.cursor = new Cursor(this.human_player);
    }

    Game.prototype.tick = function(state_controls) {
      _.invoke(this.players, 'tick');
      _.invoke(this.ai, 'tick');
      this.cursor.tick();
      Collisions.resolveCollisions(this.combat_players);
      return Ownership.checkPlanetOwnership(this.players, this.neutral_player);
    };

    Game.prototype.setupGameplay = function() {
      this.human_player;
      this.neutral_player;
      this.combat_players;
      this.players;
      throw new Error('Game mode should override Game::setupGameplay.');
    };

    Game.prototype.createAI = function() {
      var other_player, other_players, player, _i, _j, _len, _len1, _ref, _ref1, _results;
      this.ai = [];
      _ref = this.combat_players;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        if (!(player !== this.human_player)) {
          continue;
        }
        other_players = [];
        _ref1 = this.players;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          other_player = _ref1[_j];
          if (other_player !== player) {
            other_players.push(other_player);
          }
        }
        _results.push(this.ai.push(new AI(player, other_players, this.neutral_player)));
      }
      return _results;
    };

    return Game;

  })();

}).call(this);
