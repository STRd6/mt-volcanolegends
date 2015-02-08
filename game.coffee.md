Game
====

    Renderer = require("./renderer")
    World = require("./world")

    {width, height} = require "./pixie"

    module.exports = ->
      renderer = Renderer
        width: width
        height: height

      tool = require("./tools").designate

      ["touch", "move", "release"].forEach (event) ->
        renderer.on event, (point) ->
          tool[event]?(
            renderer: renderer
            point: Point(point)
          )

      world = World()

      setInterval ->
        world.tick()
        renderer.render
          characters: world.characters()
          terrain: world.terrain()
          debug: world.accessiblePositions()
      , 1/60

      return renderer.element()
