class GamePrompt
  constructor: ->

  textFor: (game, gameStatus) ->
    if gameStatus is "won"
      "Player #{game.otherPlayer()} won."
    else if gameStatus is "tied"
      "Y'all tied. Maybe go play another game."
    else
      "It's player " + game.currentPlayer + "'s turn:"

this.GamePrompt = GamePrompt
