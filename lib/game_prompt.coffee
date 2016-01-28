class GamePrompt
  constructor: ->

  textFor: (gameState, gameStatus) ->
    if gameStatus is "won"
      "Player #{gameState.otherPlayer()} won."
    else if gameStatus is "tied"
      "Y'all tied. Maybe go play another game."
    else
      "It's player " + gameState.currentPlayer + "'s turn:"

this.GamePrompt = GamePrompt
