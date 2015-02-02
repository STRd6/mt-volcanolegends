World
=====

    require "cornerstone"
    Character = require "./character"
    Graph = require "./lib/graph"

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

      neighbors: (p) ->
        [-1, 0, 1].map (y) ->
          [-1, 0, 1].map (x) ->
            [p.add(x, y), Math.sqrt(x * x + y * y)]
        .flatten()

      accessible: (start, distance) ->
        Graph.accessible
          initial: start
          neighbors: self.neighbors
          distanceMax: distance

      select: (start, end) ->
        log start, end

      characters: ->
        characters

      tick: ->
        # Pathfind for characters
        characters.first()

      terrain: ->
        I.terrain
