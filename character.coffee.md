Character
=========

This is a dwarf-like guy who walks around and digs stuff.

    module.exports = (I={}, self=Model(I)) ->
      defaults I,
        position: Point(0, 0)

      self.attrAccessor "position"

      return self
