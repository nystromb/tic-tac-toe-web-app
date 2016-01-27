PlayerMark =
  NONE: 0
  X: 1
  O: 2

class GameState
  constructor: (@board, @currentPlayer) ->

  @newGame: ->
    _ = PlayerMark.NONE
    new GameState([_, _, _, _, _, _, _, _, _], PlayerMark.X)

  makeMove: (space) ->
    newBoard = @board.slice()
    newBoard[space] = @currentPlayer
    if @currentPlayer == PlayerMark.X
      otherPlayer = PlayerMark.O
    else
      otherPlayer = PlayerMark.X
    new GameState(newBoard, otherPlayer)

this.PlayerMark = PlayerMark
this.GameState = GameState
