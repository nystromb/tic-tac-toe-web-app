PlayerMark =
  NONE: "_"
  X: "x"
  O: "o"

class Game
  constructor: (@board, @currentPlayer) ->

  @newGame: ->
    _ = PlayerMark.NONE
    new Game([_, _, _, _, _, _, _, _, _], PlayerMark.X)

  makeMove: (space) ->
    @board[space] = @currentPlayer
    @currentPlayer = @otherPlayer()
    this

  otherPlayer: () ->
    @currentPlayer == PlayerMark.X && PlayerMark.O || PlayerMark.X

  spaceIsAvailable: (space) ->
    @board[space] == PlayerMark.NONE

this.PlayerMark = PlayerMark
this.Game = Game
