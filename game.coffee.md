Game
====

    Renderer = require("./renderer")
    World = require("./world")

    {width, height} = require "./pixie"

    module.exports = ->
      renderer = Renderer
        width: width
        height: height

      # Selection event
      renderer.include require("./selection")

      renderer.on "selection", (start, end) ->
        # TODO: Translate into world coordinates
        world.select start, end

      # Pan tool
      initial = initialPan = null
      renderer.on "touch", (e) ->
        initial = Point(e)
        initialPan = renderer.pan()
      renderer.on "move", (e) ->
        delta = Point(e).subtract(initial)
        p = Point delta.x * width, delta.y * height

        renderer.pan initialPan.add p
      renderer.on "release", () ->
        initial = null

      world = World()

      setInterval ->
        world.tick()
        renderer.render world.terrain()
      , 1/60

      return renderer.element()
