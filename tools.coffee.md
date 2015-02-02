Tools
=====

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
