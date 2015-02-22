Character
=========

    PositionSet = require "./lib/position_set"

This is a dwarf-like guy who walks around and digs stuff.

    module.exports = (I={}, self=Model(I)) ->
      self.attrData "position", Point

      {neighbors} = require "./metric"

      path = []

      self.extend
        ai: (world) ->
          if path?.length
            self.position path.shift()
            return

          position = self.position()
          designations = world.designations()
          workSites = world.workSites()

          return if workSites.empty()

          time "AI"

          # if at a work site, find a neighbor to dig
          if workSites.has(position)
            target = neighbors(position).filter (p) ->
              designations.has p
            .first()

            if target
              world.dig target
          else
            path = world.pathToNearest(self.position(), workSites.has)

          timeEnd "AI"

      return self
