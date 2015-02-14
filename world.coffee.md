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

      heuristic = (a, b) ->
        a.distance(b)

      passableNeighbors = (p) ->
        self.neighbors(p).filter ([point, dist]) ->
          self.passable(point)

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

        pathTo: (start, target) ->
          Graph.aStar
            initial: start
            goal: target
            neighbors: passableNeighbors
            heuristic: heuristic

        accessible: (start, distance) ->
          Graph.accessible
            initial: start
            neighbors: passableNeighbors

            distanceMax: distance

        select: (start, end) ->
          log start, end

        characters: ->
          characters

        tick: ->
          # Remove digging designations from open spaces
          designations.forEach (p) ->
            designations.remove p if self.get(p) is 0

          # Pathfind for characters
          characters.first().ai(self)

        terrain: ->
          I.terrain
