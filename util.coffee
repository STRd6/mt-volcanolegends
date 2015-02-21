require "cornerstone"

extend global,
  log: (args...) ->
    console.log args...

  time: (label) ->
    console.time label

  timeEnd: (label) ->
    console.timeEnd label

  Model: do (OldModel=Model) ->
    (I={}, self=OldModel(I)) ->
      self.extend
        attrData: (name, DataModel) ->
          I[name] = DataModel(I[name])

          self[name] = (newValue) ->
            if arguments.length > 0
              I[name] = DataModel(newValue)
            else
              I[name]

      return self

Point::scale = (size) ->
  if arguments.length is 2
    [width, height] = arguments
  else
    if typeof size is "object"
      {width, height} = size
    else
      width = height = size

  Point(@x * width, @y * height)

["x", "y"].forEach (name) ->
  unless Rectangle.prototype[name]
    Object.defineProperty Rectangle.prototype, name,
      get: ->
        @position[name]
      set: (value) ->
        @position[name] = value

["width", "height"].forEach (name) ->
  unless Rectangle.prototype[name]
    Object.defineProperty Rectangle.prototype, name,
      get: ->
        @size[name]
      set: (value) ->
        @size[name] = value
