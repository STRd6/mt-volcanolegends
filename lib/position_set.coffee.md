Position Set
============

A set of 2d positions.

    key = ({x, y}) ->
      "#{x},#{y}"

    module.exports = ->
      map = new Map

      add = (point) ->
        map.set key(point), point

      self =
        add: add
        push: add

        toArray: ->
          Array.from(map.values())

        clear: ->
          map.clear()

        forEach: (fn) ->
          self.toArray().forEach fn

        remove: (point) ->
          map.delete key(point)
