// Generated by CoffeeScript 1.6.3
/*
Manage who owns what.
*/


(function() {
  window.Ownership = (function() {
    function Ownership() {}

    Ownership.OWNERSHIP_CHECK_FREQUENCY = 20;

    Ownership.UNIT_COVERAGE_REQUIREMENT = 30;

    Ownership.checkPlanetOwnership = function(players, neutral_player) {
      return Schedule.runEvery(Ownership.OWNERSHIP_CHECK_FREQUENCY, function() {
        var compare_player, occupying_units, opponents_units, planet, player, unit, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = players.length; _i < _len; _i++) {
          player = players[_i];
          _results.push((function() {
            var _j, _len1, _results1;
            _results1 = [];
            for (_j = 0, _len1 = players.length; _j < _len1; _j++) {
              compare_player = players[_j];
              if (compare_player === neutral_player || player === compare_player) {
                continue;
              }
              opponents_units = compare_player.getUnits();
              _results1.push((function() {
                var _k, _len2, _ref, _results2;
                _ref = player.getPlanets();
                _results2 = [];
                for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
                  planet = _ref[_k];
                  occupying_units = [];
                  _results2.push((function() {
                    var _l, _len3, _ref1, _results3;
                    _ref1 = opponents_units.getAll();
                    _results3 = [];
                    for (_l = 0, _len3 = _ref1.length; _l < _len3; _l++) {
                      unit = _ref1[_l];
                      if (unit.getPosition().intersectsWith(planet.getPosition())) {
                        occupying_units.push(unit);
                        if (occupying_units.length > Ownership.UNIT_COVERAGE_REQUIREMENT) {
                          Ownership.transferOwnership(planet, occupying_units, compare_player, player);
                          break;
                        } else {
                          _results3.push(void 0);
                        }
                      } else {
                        _results3.push(void 0);
                      }
                    }
                    return _results3;
                  })());
                }
                return _results2;
              })());
            }
            return _results1;
          })());
        }
        return _results;
      }, this);
    };

    Ownership.transferOwnership = function(planet, units, player, old_player) {
      var unit, _i, _len;
      for (_i = 0, _len = units.length; _i < _len; _i++) {
        unit = units[_i];
        player.getUnits().remove(unit);
      }
      player.addPlanetOwnership(planet);
      return old_player.removePlanetOwnership(planet);
    };

    return Ownership;

  })();

}).call(this);
