Tools
=====

    rectangleFromSelection = (start, end) ->
      if end.x > start.x
        x = 0
      else
        x = 1

      if end.y > start.y
        y = 0
      else
        y = 1

      Rectangle.fromPoints(start.add(Point(x, y)), end)

    module.exports =
      pan: do ->
        initial = initialPan = null
        touch: ({renderer, point}) ->
          initial = point
          initialPan = renderer.pan()
        move: ({renderer, point}) ->
          delta = point.subtract(initial)
          p = Point delta.x * renderer.width(), delta.y * renderer.height()
          renderer.pan initialPan.add p
      designate: do ->
        initialPosition = null
        touch: ({worldPosition}) ->
          initialPosition = worldPosition
        move: ({renderer, worldPosition}) ->
          renderer.activeDesignation rectangleFromSelection(initialPosition, worldPosition)
        release: ({world, worldPosition}) ->
          world.designate worldPosition
