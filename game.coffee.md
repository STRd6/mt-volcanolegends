Game
====

    Renderer = require("./renderer")
    World = require("./world")

    module.exports = ->
      renderer = Renderer
        width: 512
        height: 512

      renderer.include require("./selection")

      renderer.on "selection", log

      world = World()

      setInterval ->
        world.tick()
        renderer.render world.terrain()
      , 1/60

      return renderer.element()
