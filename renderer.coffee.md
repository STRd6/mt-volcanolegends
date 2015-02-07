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
        drawCharacter: (character) ->
          {x, y} = character.position().add(0.5, 0.5).scale(tileSize)

          self.drawCircle
            x: x
            y: y
            radius: tileSize/2
            color: "blue"

        drawTile: (x, y, color) ->
          self.drawRect
            x: x * tileSize
            y: y * tileSize
            width: tileSize
            height: tileSize
            color: color

        render: ({terrain, characters, debug}) ->
          self.fill "#000"
          {x, y} = self.pan()
          self.withTransform Matrix.translation(x, y), ->
            terrain.forEach (row, y) ->
              row.forEach (tile, x) ->
                self.drawTile x, y, colors[tile]

            characters.forEach self.drawCharacter
            debug.forEach ({x, y}) ->
              self.drawTile x, y, "rgba(255, 0, 255, 0.25)"

      return self
