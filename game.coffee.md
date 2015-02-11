Game
====

    Renderer = require("./renderer")
    World = require("./world")

    {width, height} = require "./pixie"

    TOOLS = require("./tools")

    module.exports = ->
      register = require("./lib/hotkeys")
      tool = TOOLS.designate

      actions = Observable ["designate", "pan"].map (name) ->
        name: name
        perform: ->
          tool = TOOLS[name]

      register "0", ->
        tool = TOOLS.pan

      register "1", ->
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
            world: world
            worldPosition: toWorld Point(point)
          )

      world = World()

      setInterval ->
        world.tick()
        renderer.render
          characters: world.characters()
          designations: world.designations()
          terrain: world.terrain()
          debug: world.accessiblePositions()
      , 1/60

      ActionBar = require "action-bar"
      gameElement = document.createElement "div"
      gameElement.appendChild renderer.element()
      gameElement.appendChild ActionBar(actions: actions)

      return gameElement
