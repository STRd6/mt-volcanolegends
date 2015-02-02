World
=====

    require "cornerstone"
    Character = require "./character"

    module.exports = (I={}) ->
      defaults I,
        width: 256
        height: 256

      I.terrain = [0...I.height].map ->
        [0...I.width].map ->
          Math.round rand()

      characters = [
        Character()
      ]

      select: (start, end) ->
        log start, end

      characters: ->
        characters

      tick: ->

      terrain: ->
        I.terrain
