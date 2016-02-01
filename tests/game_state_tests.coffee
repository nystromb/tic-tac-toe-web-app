describe "tic tac toe game state", ->
  _ = PlayerMark.NONE
  x = PlayerMark.X
  o = PlayerMark.O
  board = [_, _, _, _, _, _, _, _, _]

  describe "making a move", ->

    it "marks the given space with the current player's mark", ->
      gameState = GameState.newGame()

      gameState.makeMove(0)
      gameState.makeMove(1)
      gameState.makeMove(2)

      expect(gameState.board[0]).toEqual x
      expect(gameState.board[1]).toEqual o
      expect(gameState.board[2]).toEqual x

  describe "getting the other player", ->

    it "returns the player who is not the current player", ->
      gameState = GameState.newGame()

      expect(gameState.otherPlayer()).not.toEqual(gameState.currentPlayer)

  describe "checking if a space is available for a move", ->

    it "is true if target space is unmarked", ->
      gameState = GameState.newGame()

      expect(gameState.spaceIsAvailable(0)).toBe true

    it "is false if target space is marked", ->
      gameState = GameState.newGame()

      gameState.makeMove(0)

      expect(gameState.spaceIsAvailable(0)).toBe false
