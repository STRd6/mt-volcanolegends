World
=====

    require "cornerstone"
    Character = require "./character"
    Graph = require "./lib/graph"
    PositionSet = require "./lib/position_set"

    module.exports = (I={}) ->
      defaults I,
        width: 64
        height: 36

      I.terrain = [0...I.height].map ->
        [0...I.width].map ->
          Math.round rand()

      characters = [
        Character()
      ]

      accessiblePositions = []

      designations = PositionSet()

      self =
        accessiblePositions: ->
          accessiblePositions

        set: ({x, y}, value) ->
          return unless 0 <= y < I.height
          return unless 0 <= x < I.width

          I.terrain[y][x] = value

        get: (p) ->
          I.terrain[p.y]?[p.x]

        passable: (p) ->
          self.get(p) is 0

        designate: (p) ->
          designations.push p

        designations: ->
          designations

        neighbors: (p) ->
          [-1, 0, 1].map (y) ->
            [-1, 0, 1].map (x) ->
              [p.add(x, y), Math.sqrt(x * x + y * y)]
          .flatten()

        accessible: (start, distance) ->
          Graph.accessible
            initial: start
            neighbors: (p) ->
              self.neighbors(p).filter ([point, dist]) ->
                self.passable(point)

            distanceMax: distance

        select: (start, end) ->
          log start, end

        characters: ->
          characters

        tick: ->
          # Pathfind for characters
          accessiblePositions = self.accessible characters.first().position(), 10

          # Process designations
          # TODO: Schedule characters to move around rather than just clearing them
          designations.forEach (p) ->
            self.set p, 0

          designations.clear()

        terrain: ->
          I.terrain
