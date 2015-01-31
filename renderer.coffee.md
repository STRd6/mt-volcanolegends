Renderer
========

    TouchCanvas = require "touch-canvas"

    colors = ["#FFF", "#000"]

    tileSize = 16

    module.exports = (I) ->
      self = TouchCanvas(I).extend
        drawTile: (tile, x, y) ->
          self.drawRect
            x: x * tileSize
            y: y * tileSize
            width: tileSize
            height: tileSize
            color: colors[tile]

        pan: ->
          Matrix.translation(0, 0)

        render: (data) ->
          self.withTransform self.pan(), ->
            data.forEach (row, y) ->
              row.forEach (tile, x) ->
                self.drawTile tile, x, y
