describe "tic tac toe game state", ->
  _ = PlayerMark.NONE
  x = PlayerMark.X
  o = PlayerMark.O
  board = [_, _, _, _, _, _, _, _, _]

  describe "making a move", ->

    it "marks the given space with the current player's mark", ->
      game = Game.newGame()

      game.makeMove(0).makeMove(1).makeMove(2)

      expect(game.board[0]).toEqual x
      expect(game.board[1]).toEqual o
      expect(game.board[2]).toEqual x

  describe "getting the other player", ->

    it "returns the player who is not the current player", ->
      game = Game.newGame()

      expect(game.otherPlayer()).not.toEqual(game.currentPlayer)

  describe "checking if a space is available for a move", ->

    it "is true if target space is unmarked", ->
      game = Game.newGame()

      expect(game.spaceIsAvailable(0)).toBe true

    it "is false if target space is marked", ->
      game = Game.newGame()

      game.makeMove(0)

      expect(game.spaceIsAvailable(0)).toBe false
