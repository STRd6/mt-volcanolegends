Mt. Volcanolegends
==================

    require "cornerstone"

    renderer = require("./renderer")
      width: 512
      height: 512

    world = require("./world")()

    document.body.appendChild renderer.element()

    setInterval ->
      world.tick()
      renderer.render world.terrain()
    , 1/60
