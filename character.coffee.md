Character
=========

This is a dwarf-like guy who walks around and digs stuff.

    module.exports = (I={}, self=Model(I)) ->
      defaults I,
        position: Point(0, 0)

      self.attrAccessor "position"

      adjacent = (p1, p2) ->
        p2.subtract(p1).magnitude() < 1.5 # Closer than approx root 2

      self.extend
        ai: (world) ->
          position = self.position()
          designationsArray = world.designations().toArray()

          # If a designation is adjacent to us dig it
          adjacentDesignations = designationsArray.filter (p) ->
            adjacent(p, position) 

          if d = adjacentDesignations.first()
            # TODO: Non-instantaneous digging
            world.set d, 0
          else
            # Pathfind to a position that has adjacent designations
            accessiblePositions = world.accessible(self.position(), 10)

            nearDesignations = accessiblePositions.filter ([position, distance]) ->
              # Find positions with adjacent designations
              designationsArray.reduce (memo, designation) ->
                memo || adjacent(designation, position)
              , false

            
            console.log nearDesignations

            if p = nearDesignations.first()
              self.position p.first()

          # else
          # Move to a nearby position that we can reach that has
          # designations we can dig

      return self
