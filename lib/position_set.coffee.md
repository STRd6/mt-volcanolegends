Position Set
============

A set of 2d positions.

    key = ({x, y}) ->
      "#{x},#{y}"

    module.exports = ->
      map = new Map

      add = (point) ->
        map.set key(point), point

      add: add
      push: add

      clear: ->
        map.clear()

      forEach: (fn) ->
        Array.from(map.values()).forEach fn

      remove: (point) ->
        map.delete key(point)
