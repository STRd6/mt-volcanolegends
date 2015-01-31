Game
====

    Renderer = require("./renderer")
    World = require("./world")

    {width, height} = require "./pixie"

    module.exports = ->
      renderer = Renderer
        width: width
        height: height

      renderer.include require("./selection")

      renderer.on "selection", (start, end) ->
        # TODO: Translate into world coordinates
        world.select start, end

      world = World()

      setInterval ->
        world.tick()
        renderer.render world.terrain()
      , 1/60

      return renderer.element()
