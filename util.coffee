global.log = (args...) ->
  console.log args...

Point::scale = (size) ->
  if arguments.length is 2
    [width, height] = arguments
  else
    if typeof size is "object"
      {width, height} = size
    else
      width = height = size

  Point(@x * width, @y * height)
