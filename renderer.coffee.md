Renderer
========

    TouchCanvas = require "touch-canvas"

    colors = ["tan", "#444"]

    tileSize = 16
    designationColor = "rgba(255, 255, 0, 0.25)"

    module.exports = (I) ->
      self = TouchCanvas(I)

      I.pan = Point I.pan

      self.attrAccessor "pan" # Pixel coordinates
      self.attrAccessor "activeDesignation" # World Coordinates

      self.extend
        drawCharacter: (character) ->
          {x, y} = character.position().add(0.5, 0.5).scale(tileSize)

          self.drawCircle
            x: x
            y: y
            radius: tileSize/2
            color: "blue"

        drawItem: (item) ->
          {x, y} = item.position().add(0.5, 0.5).scale(tileSize)

          self.drawCircle
            x: x
            y: y
            radius: tileSize/4
            color: "gray"

        drawTile: (x, y, color) ->
          self.drawRect
            x: x * tileSize
            y: y * tileSize
            width: tileSize
            height: tileSize
            color: color

        size: ->
          width: self.width()
          height: self.height()

        tileSize: ->
          width: tileSize
          height: tileSize

        render: ({terrain, characters, designations, debug, items}) ->
          self.fill "#000"
          {x, y} = self.pan()
          self.withTransform Matrix.translation(x, y), ->
            terrain.forEach (row, y) ->
              row.forEach (tile, x) ->
                self.drawTile x, y, colors[tile]

            items.forEach self.drawItem

            characters.forEach self.drawCharacter
            debug.forEach ({x, y}) ->
              self.drawTile x, y, "rgba(255, 0, 255, 0.25)"

            designations.forEach ({x, y}) ->
              self.drawTile x, y, designationColor

            if designation = self.activeDesignation()
              {x, y, width, height} = designation
              self.drawRect
                x: x * tileSize
                y: y * tileSize
                width: width * tileSize
                height: height * tileSize
                color: designationColor

      return self
