Tools
=====

    rectangleFromSelection = (start, end) ->
      p1 = Point(0, 0)
      p2 = Point(0, 0)
      if end.x > start.x
        p2.x = 1
      else
        p1.x = 1

      if end.y > start.y
        p2.y = 1
      else
        p1.y = 1

      Rectangle.fromPoints(start.add(p1), end.add(p2))

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
          rectangleFromSelection(initialPosition, worldPosition).each (x, y) ->
            world.designate Point(x, y)
