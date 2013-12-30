// Generated by CoffeeScript 1.6.3
/*
A player who has control over planets and units.
*/


(function() {
  window.Player = (function() {
    Player.UNIT_GENERATION_SPEED = 10;

    function Player(color) {
      this.color = color;
      this.planets = [];
      this.units = new UnitCollection();
    }

    Player.prototype.createRandomPlanets = function(number) {
      var edge_buffer, i, _i, _results;
      edge_buffer = Planet.MAX_PLANET_RADIUS + Planet.UNIT_DISTANCE_FROM_PLANET + Planet.UNIT_DISTANCE_FROM_PLANET_VARIANCE;
      _results = [];
      for (i = _i = 0; 0 <= number ? _i <= number : _i >= number; i = 0 <= number ? ++_i : --_i) {
        _results.push(this.planets.push(new Planet(Random.integer(edge_buffer, window.innerWidth - edge_buffer), Random.integer(edge_buffer, window.innerHeight - edge_buffer), Random.integer(Planet.MIN_PLANET_RADIUS, Planet.MAX_PLANET_RADIUS), this.color)));
      }
      return _results;
    };

    Player.prototype.tick = function() {
      _.invoke(this.planets, 'tick');
      this.units.tickAll();
      this.generatePlanetUnits();
      return _.invoke(this.planets, 'drawPlanet');
    };

    Player.prototype.generatePlanetUnits = function() {
      var planet, _i, _len, _ref, _results;
      if (ticks % Player.UNIT_GENERATION_SPEED !== 0) {
        return;
      }
      _ref = this.planets;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        planet = _ref[_i];
        _results.push(this.units.add(planet.spawnUnit()));
      }
      return _results;
    };

    Player.prototype.getUnits = function() {
      return this.units;
    };

    Player.prototype.getPlanets = function() {
      return this.planets;
    };

    return Player;

  })();

}).call(this);
