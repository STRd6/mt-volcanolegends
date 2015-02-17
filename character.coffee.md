Character
=========

This is a dwarf-like guy who walks around and digs stuff.

    module.exports = (I={}, self=Model(I)) ->
      defaults I,
        position: Point(0, 0)

      self.attrAccessor "position"

      adjacent = (p1, p2) ->
        p2.subtract(p1).magnitude() < 1.5 # Closer than approx root 2

      path = []

      self.extend
        ai: (world) ->
          if path.length
            self.position path.shift()
            return

          position = self.position()
          designationsArray = world.designations().toArray()

          return if designationsArray.length is 0
          time "AI"

          # If a designation is adjacent to us dig it
          adjacentDesignations = designationsArray.filter (p) ->
            adjacent(p, position)

          if d = adjacentDesignations.first()
            # TODO: Non-instantaneous digging
            world.dig d
          else
            # Pathfind to a position that has adjacent designations
            accessiblePositions = world.accessible(self.position(), 10)

            nearDesignations = accessiblePositions.filter ([position, distance]) ->
              # Find positions with adjacent designations
              designationsArray.reduce (memo, designation) ->
                memo || adjacent(designation, position)
              , false

            # TODO: Be sure to sort to go to the closest!
            if p = nearDesignations.first()
              # TODO: Set a path
              path = world.pathTo(self.position(), p.first())
            else
              # TODO: Check farther designations

          timeEnd "AI"

      return self
