Mt. Volcanolegends
==================

    require "cornerstone"
    require "./util"

    style = document.createElement "style"
    style.innerText = require "./style"

    document.head.appendChild style

    Game = require "./game"
    document.body.appendChild Game()
