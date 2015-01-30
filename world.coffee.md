World
=====

    require "cornerstone"

    module.exports = (I={}) ->
      I.terrain = [0...32].map ->
        [0...32].map ->
          Math.round rand()

      tick: ->
        I.terrain[rand(32)][rand(32)] = Math.round rand()

      terrain: ->
        I.terrain
