Graph Search
============

    PriorityQueue = require "priority_queue"

    module.exports =

A* Pathfinding

Return a path from initial to goal or `undefined` if no path exists.

Initial and goal are assumed to be nodes that have a toString function that
uniquely identifies nodes.

      aStar: ({initial, goal, heuristic, neighbors, equals}) ->
        heuristic ?= -> 0
        neighbors ?= -> []
        equals ?= (a, b) ->
          a.toString() == b.toString()

        # Prevent hanging by capping max iterations
        iterations = 0
        iterationsMax = 1000

        # Table to track our node meta-data
        # TODO: Need to add unique map key function for Points, etc.
        nodes = new Map

        openSet = PriorityQueue
          low: true

        push = (node, current, distance=1) ->
          if previousNode = nodes.get(node)
            {g, h} = previousNode

          g ?= Infinity
          h ?= heuristic(node, goal)

          currentG = nodes.get(current)?.g ? 0

          nodeData =
            g: currentG + distance
            h: h
            parent: current
            node: node

          # Update if better
          if nodeData.g < g
            nodes.set(node, nodeData)
            openSet.push node, nodeData.g + h

        getPath = (node) ->
          path = [node]

          while (node = nodes.get(node).parent) != null
            path.push node

          return path.reverse()

        push initial, null, 0

        while openSet.size() > 0
          return if iterations >= iterationsMax
          iterations += 1

          current = openSet.pop()

          if equals current, goal
            return getPath(goal)

          neighbors(current).forEach ([node, distance]) ->
            push node, current, distance

Find all the nodes accessible within the given distance.

      accessible: ({initial, neighbors, distanceMax, key}) ->
        neighbors ?= -> []
        distanceMax ?= 1
        key ?= (node) ->
          "#{node}"

        get = (node) ->
          nodes.get key node

        set = (node, value) ->
          nodes.set key(node), value

        # Table to track our node meta-data
        nodes = new Map

        openSet = PriorityQueue
          low: true

        push = (node, current, distance=1) ->
          g = get(node)?.g ? Infinity

          nodeData =
            g: (get(current)?.g ? 0) + distance
            node: node

          # Update if better
          if nodeData.g < g and nodeData.g <= distanceMax
            set(node, nodeData)
            openSet.push node, nodeData.g

        push initial, null, 0

        while openSet.size() > 0
          current = openSet.pop()

          neighbors(current).forEach ([node, distance]) ->
            push node, current, distance

        Array.from nodes.values()
