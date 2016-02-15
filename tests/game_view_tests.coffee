class MockAPI
  constructor: (@responseDataToUse) ->

  updateGame: (game, updateAction) ->
    updateAction(@responseDataToUse)

class ManualTriggerMockAPI
  constructor: (@responseDataToUse) ->

  updateGame: (game, updateAction) ->
    @updateAction = updateAction

  triggerGameUpdate: ->
    @updateAction(@responseDataToUse)
    @updateAction(@responseDataToUse)

describe "game view updates", ->

  beforeEach ->
    setFixtures('<h3 class="prompt">foo</h3>' +
      '<table><tr><td data-space-id="0" data-status="unmarked">_</td>' +
      '<td data-space-id="1" data-status="unmarked">_</td></tr></table>')
    @firstBoardSpace = $("[data-space-id=0]")
    @secondBoardSpace = $("[data-space-id=1]")

  describe "marking the board", ->

    it "marks the element with the current player's mark", ->
      game = Game.newGame(new MockAPI(""))
      expectedMark = game.currentPlayer
      new GameView(game)

      @firstBoardSpace.click()

      expect(@firstBoardSpace.text()).toEqual expectedMark
      expect(@firstBoardSpace.data("status")).toEqual "marked"

    it "prevents marking spaces while updating game", ->
      api = new ManualTriggerMockAPI("")
      game = Game.newGame(api)
      expectedMark = game.currentPlayer
      new GameView(game)

      @firstBoardSpace.click()
      @secondBoardSpace.click()
      api.triggerGameUpdate()

      expect(@firstBoardSpace.text()).toEqual expectedMark
      expect(@secondBoardSpace.text()).toEqual PlayerMark.NONE

    it "reenables marking spaces after game update/computer move", ->
      api = new ManualTriggerMockAPI(gameState: "inProgress", bestMove: 8)
      game = Game.newGame(api)
      new GameView(game)

      @firstBoardSpace.click()
      api.triggerGameUpdate()
      expectedMark = game.currentPlayer
      @secondBoardSpace.click()

      expect(@secondBoardSpace.text()).toEqual expectedMark

    it "prevents marking spaces after the game is over", ->
      new GameView(Game.newGame(new MockAPI(gameState: "won")))

      @firstBoardSpace.click()
      @secondBoardSpace.click()

      expect(@secondBoardSpace.text()).toEqual PlayerMark.NONE

  describe "handling the computer's move", ->

    it "marks the board with the computer move after the human player makes their move", ->
      game = Game.newGame(new MockAPI(gameState: "inProgress", bestMove: 1))
      initialPlayer = game.currentPlayer
      new GameView(game)

      @firstBoardSpace.click()

      expect(@secondBoardSpace.text()).toEqual game.otherPlayer()
      expect(game.currentPlayer).toEqual initialPlayer

    it "sets human player as the current player after computer player makes their move", ->
      game = Game.newGame(new MockAPI(gameState: "inProgress", bestMove: 1))
      initialPlayer = game.currentPlayer
      new GameView(game)

      @firstBoardSpace.click()

      expect(game.currentPlayer).toEqual initialPlayer

    it "does not mark the computer move if the player won", ->
      game = Game.newGame(new MockAPI(gameState: "won", bestMove: 1))
      initialPlayer = game.currentPlayer
      new GameView(game)

      @firstBoardSpace.click()

      expect(@secondBoardSpace.text()).toEqual "_"

  describe "updating the game prompt", ->

    beforeEach ->
      @prompt = $(".prompt")

    it "displays the current player's turn when api reports the game is in progress", ->
      game = Game.newGame(new MockAPI(gameState: "inProgress"))
      new GameView(game)

      expect(@prompt.text()).toContain game.currentPlayer

      @firstBoardSpace.click()
      expect(@prompt.text()).toContain game.currentPlayer

      @secondBoardSpace.click()
      expect(@prompt.text()).toContain game.currentPlayer

    it "says that the previous player won when api reports game has been won", ->
      game = Game.newGame(new MockAPI(gameState: "won"))
      new GameView(game)

      expect(@prompt.text()).toContain game.currentPlayer

      @firstBoardSpace.click()
      expect(@prompt.text()).toContain "#{game.otherPlayer()} won"

      @secondBoardSpace.click()
      expect(@prompt.text()).toContain "#{game.otherPlayer()} won"

    it "says the game is tied when api reports game is tied", ->
      game = Game.newGame(new MockAPI(gameState: "tied"))
      new GameView(game)

      expect(@prompt.text()).toContain game.currentPlayer

      @firstBoardSpace.click()
      expect(@prompt.text()).toContain "tied"
