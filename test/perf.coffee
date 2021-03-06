require "../util"

describe "perf", ->
  it "adjacent", ->
    adjacentA = (p1, p2) ->
      (-1 <= (p1.x - p2.x) <= 1) &&
      (-1 <= (p1.y - p2.y) <= 1)

    adjacentB = (p1, p2) ->
      p2.subtract(p1).magnitude() < 1.5 # Closer than approx root 2

    numPoints = 10000
    points = []

    numPoints.times (n) ->
      points[n] = Point(rand(256), rand(256))

    iterations = numPoints - 1

    time "AdjacentA"
    iterations.times (i) ->
      adjacentA(points[i], points[i+1])
    timeEnd "AdjacentA"

    time "AdjacentB"
    iterations.times (i) ->
      adjacentB(points[i], points[i+1])
    timeEnd "AdjacentB"
