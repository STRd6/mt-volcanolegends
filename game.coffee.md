Game
====

    Renderer = require("./renderer")
    World = require("./world")

    {width, height} = require "./pixie"

    module.exports = ->
      renderer = Renderer
        width: width
        height: height

      tool = require("./tools").pan

      ["touch", "move", "release"].forEach (event) ->
        renderer.on event, (point) ->
          tool[event]?(
            renderer: renderer
            point: Point(point)
          )

      world = World()

      console.log world.accessible(Point(0, 0), 1)

      setInterval ->
        world.tick()
        renderer.render
          characters: world.characters()
          terrain: world.terrain()
      , 1/60

      return renderer.element()
