
    renderer = require("./renderer")()

    document.body.appendChild renderer.element()
    
    setInterval ->
      renderer.render [[0, 1, 0, 1]]
