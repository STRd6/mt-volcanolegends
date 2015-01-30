
    renderer = require("./renderer")()

    document.body.appendChild renderer.element()

    data = """
      00001111
      00111100
      11100010
      10101111
      01010001
      00001001
      11000100
      00000011
    """.split("\n").map (row) ->
      row.split("").map (n) ->
        parseInt(n)

    setInterval ->
      renderer.render data
