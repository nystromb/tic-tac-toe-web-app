describe "tic tac toe game state", ->
  _ = PlayerMark.NONE
  x = PlayerMark.X
  o = PlayerMark.O
  board = [_, _, _, _, _, _, _, _, _]

  describe "making a move", ->

    it "returns a new game state in which the current player has marked the given space", ->
      gameState = GameState.newGame()

      nextGameState = gameState.makeMove(0)

      expect(nextGameState.board[0]).toEqual x

    it "returns a new game state in which the other player is now the current player", ->
      gameState = GameState.newGame()

      nextGameState = gameState.makeMove(0)

      expect(gameState.currentPlayer).toEqual x
      expect(nextGameState.currentPlayer).toEqual o

  describe "getting the other player", ->

    it "returns the player who is not the current player", ->
      gameState = GameState.newGame()

      expect(gameState.otherPlayer()).not.toEqual(gameState.currentPlayer)
