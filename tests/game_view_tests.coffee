class NullAPI
  updateGame: ->

class MockAPI
  constructor: (@responseDataToUse, @updateGameCallback) ->

  updateGame: (game) ->
    @updateGameCallback(@responseDataToUse)

describe "game view updates", ->

  it "", ->
    fixture = setFixtures('<td id="0" class="unmarked-space">-</td>')
    element = fixture.find('.unmarked-space')
    view = new GameView()
    game = Game.newGame(new NullAPI())
    game.makeMove(0)

    view.update(game)

    expect(element.html()).toEqual "x"
    expect(element).toHaveClass "marked-space"
