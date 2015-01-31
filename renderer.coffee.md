Renderer
========

    TouchCanvas = require "touch-canvas"

    colors = ["tan", "#444"]

    tileSize = 16

    module.exports = (I) ->
      self = TouchCanvas(I)

      I.pan = Point I.pan

      self.attrAccessor "pan"

      self.extend
        drawTile: (tile, x, y) ->
          self.drawRect
            x: x * tileSize
            y: y * tileSize
            width: tileSize
            height: tileSize
            color: colors[tile]

        render: (data) ->
          self.fill "#000"
          {x, y} = self.pan()
          self.withTransform Matrix.translation(x, y), ->
            data.forEach (row, y) ->
              row.forEach (tile, x) ->
                self.drawTile tile, x, y

      return self
