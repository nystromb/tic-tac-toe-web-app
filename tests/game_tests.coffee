class NullAPI
  updateGame: (game) ->

describe "tic tac toe game state", ->
  _ = PlayerMark.NONE
  x = PlayerMark.X
  o = PlayerMark.O

  describe "handling a turn", ->

    it "marks the given space with the current player's mark", ->
      game = Game.newGame(new NullAPI())

      game.handleTurn(0, ->).handleTurn(1, ->).handleTurn(2, ->)

      expect(game.board[0]).toEqual x
      expect(game.board[1]).toEqual o
      expect(game.board[2]).toEqual x

    it "calls API and triggers update action after a move is made", ->
      api = new NullAPI()
      spyOn(api, "updateGame")
      updateAction = ->
      game = Game.newGame(api)

      game.handleTurn(0, updateAction)

      expect(api.updateGame).toHaveBeenCalledWith(game, updateAction)

    it "passes the API the game state after the move has been made", ->
      api = new NullAPI()

      spyOn(api, "updateGame").and.callFake((gameGivenToAPI) ->
        expect(gameGivenToAPI.currentPlayer).toEqual o
        expect(gameGivenToAPI.board).toEqual [x, _, _, _, _, _, _, _, _])

      game = Game.newGame(api).handleTurn(0)

  describe "getting the other player", ->

    it "returns the player who is not the current player", ->
      game = Game.newGame(new NullAPI())

      expect(game.otherPlayer()).not.toEqual(game.currentPlayer)

  describe "checking if a space is available for a move", ->

    it "is true if target space is unmarked", ->
      game = Game.newGame(new NullAPI())

      expect(game.spaceIsAvailable(0)).toBe true

    it "is false if target space is marked", ->
      game = Game.newGame(new NullAPI())

      game.makeMove(0)

      expect(game.spaceIsAvailable(0)).toBe false
