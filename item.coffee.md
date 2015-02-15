Item
====

Items are things like stone blocks, chairs, seed pods or whatever.

    module.exports = (I={}, self=Model(I)) ->
      defaults I,
        position: Point(0, 0)

      self.attrAccessor "name", "position"

      return self
