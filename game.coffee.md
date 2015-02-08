Game
====

    Renderer = require("./renderer")
    World = require("./world")

    {width, height} = require "./pixie"

    TOOLS = require("./tools")

    module.exports = ->
      register = require("./lib/hotkeys")

      tool = TOOLS.designate

      register "0", ->
        log "yolo"
        tool = TOOLS.pan

      register "1", ->
        log "yolo2"
        tool = TOOLS.designate

      renderer = Renderer
        width: width
        height: height

      toScreen = (point) ->
        point.scale(renderer.size()).add(renderer.pan())
      toWorld = (point) ->
        toScreen(point).scale(Size(renderer.tileSize()).inverse()).floor()

      ["touch", "move", "release"].forEach (event) ->
        renderer.on event, (point) ->
          tool[event]?(
            renderer: renderer
            point: Point(point)
            world: toWorld Point(point)
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
