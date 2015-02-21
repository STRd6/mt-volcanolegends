require "../util"

describe "attrData", ->
  it "should be pretty cool", ->
    model = Model
      position:
        x: 5
        y: 5

    model.attrData "position", Point

    assert model.position().add
