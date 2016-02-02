PlayerMark =
  NONE: "_"
  X: "x"
  O: "o"

class Game
  constructor: (@api, @board, @currentPlayer) ->

  @newGame: (api) ->
    _ = PlayerMark.NONE
    new Game(api, [_, _, _, _, _, _, _, _, _], PlayerMark.X)

  handleTurn: (playedSpace, updateAction) ->
    @makeMove(playedSpace)
    @gameUpdateAction(updateAction)
    this

  makeMove: (space) ->
    @board[space] = @currentPlayer
    @currentPlayer = @otherPlayer()
    this

  gameUpdateAction: (action) ->
    @api.updateGame(this, action)

  otherPlayer: ->
    @currentPlayer is PlayerMark.X && PlayerMark.O || PlayerMark.X

  spaceIsAvailable: (space) ->
    @board[space] is PlayerMark.NONE

this.PlayerMark = PlayerMark
this.Game = Game
