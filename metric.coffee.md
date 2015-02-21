Metric
======

    module.exports =
      adjacent: (p1, p2) ->
        (-1 <= (p1.x - p2.x) <= 1) &&
        (-1 <= (p1.y - p2.y) <= 1)
      neighbors: (p) ->
        [
          p.add(-1, -1)
          p.add( 0, -1)
          p.add( 1, -1)
          p.add(-1, 0)
          p.add( 0, 0)
          p.add( 1, 0)
          p.add(-1, 1)
          p.add( 0, 1)
          p.add( 1, 1)
        ]
