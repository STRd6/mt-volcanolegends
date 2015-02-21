Graph = require "../lib/graph"

describe "A*", ->
  it "should find the shortest path between nodes", ->
    result = Graph.aStar
      initial:0
      goal: 10
      neighbors: (value) ->
        [
          [value - 1, 1]
          [value + 1, 1]
        ]
      heuristic: (node, goal) ->
        Math.abs(goal - node)

    assert.equal result.length, 11

  it "should work with a goal function", ->
    result = Graph.aStar
      initial:0
      goal: (n) ->
        n is 10
      neighbors: (value) ->
        [
          [value - 1, 1]
          [value + 1, 1]
        ]
      heuristic: (node, goal) ->
        Math.abs(goal - node)

    assert.equal result.length, 11

describe "accessible", ->
  it "should list the node that are accessible within the distance", ->
    result = Graph.accessible
      initial:0
      distanceMax: 5
      neighbors: (value) ->
        [
          [value - 1, 1]
          [value + 1, 1]
        ]

    assert.equal result.length, 11
