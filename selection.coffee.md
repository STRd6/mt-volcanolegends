Selection
=========

    module.exports = (I, self) ->
      initial = null

      self.on "touch", (point) ->
        initial = point

      self.on "release", (point) ->
        if initial
          self.trigger "selection", initial, point

        initial = null
