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

describe "game view updates", ->

  beforeEach ->
    @fixture = setFixtures('<h3 class="prompt">foo</h3>' +
      '<table><tr><td id="0" class="unmarked-space">_</td>' +
      '<td id="1" class="unmarked-space">_</td></tr></table>')

  describe "marking the board", ->

    it "marks the element with the current player's mark", ->
      boardSpace = $("#0")
      game = Game.newGame(new MockAPI(""))
      view = new GameView(game)
      expectedMark = game.currentPlayer

      boardSpace.click()

      expect(boardSpace.text()).toEqual expectedMark
      expect(boardSpace).toHaveClass "marked-space"

    it "prevents marking spaces while updating game", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new ManualTriggerMockAPI("")
      game = Game.newGame(api)
      view = new GameView(game)
      expectedMark = game.currentPlayer

      firstBoardSpace.click()
      secondBoardSpace.click()
      api.triggerGameUpdate()

      expect(firstBoardSpace.text()).toEqual expectedMark
      expect(secondBoardSpace.text()).toEqual PlayerMark.NONE

    it "reenables marking spaces after game update/computer move", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new ManualTriggerMockAPI(gameState: "inProgress", bestMove: 8)
      game = Game.newGame(api)
      view = new GameView(game)

      firstBoardSpace.click()
      api.triggerGameUpdate()
      api.triggerGameUpdate()
      expectedMark = game.currentPlayer
      secondBoardSpace.click()

      expect(secondBoardSpace.text()).toEqual expectedMark

    it "prevents marking spaces after the game is over", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new MockAPI(gameState: "won")
      game = Game.newGame(api)
      view = new GameView(game)

      firstBoardSpace.click()
      secondBoardSpace.click()

      expect(secondBoardSpace.text()).toEqual PlayerMark.NONE

  describe "handling the computer's move", ->

    it "marks the board with the computer move after the human player makes their move", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new MockAPI(gameState: "inProgress", bestMove: 1)
      game = Game.newGame(api)
      view = new GameView(game)
      initialPlayer = game.currentPlayer

      firstBoardSpace.click()

      expect(secondBoardSpace.text()).toEqual game.otherPlayer()
      expect(game.currentPlayer).toEqual initialPlayer

    it "sets human player as the current player after computer player makes their move", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new MockAPI(gameState: "inProgress", bestMove: 1)
      game = Game.newGame(api)
      view = new GameView(game)
      initialPlayer = game.currentPlayer

      firstBoardSpace.click()

      expect(game.currentPlayer).toEqual initialPlayer

    it "does not mark the computer move if the player won", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new MockAPI(gameState: "won", bestMove: 1)
      game = Game.newGame(api)
      view = new GameView(game)
      initialPlayer = game.currentPlayer

      firstBoardSpace.click()

      expect(secondBoardSpace.text()).toEqual "_"

  describe "updating the game prompt", ->

    it "displays the current player's turn when api reports the game is in progress", ->
      prompt = $(".prompt")
      api = new MockAPI(gameState: "inProgress")
      game = Game.newGame(api)
      view = new GameView(game)

      expect(prompt.text()).toContain game.currentPlayer

      $("#0").click()
      expect(prompt.text()).toContain game.currentPlayer

      $("#1").click()
      expect(prompt.text()).toContain game.currentPlayer

    it "says that the previous player won when api reports game has been won", ->
      prompt = $(".prompt")
      api = new MockAPI(gameState: "won")
      game = Game.newGame(api)
      view = new GameView(game)

      expect(prompt.text()).toContain game.currentPlayer

      $("#0").click()
      expect(prompt.text()).toContain "#{game.otherPlayer()} won"

      $("#1").click()
      expect(prompt.text()).toContain "#{game.otherPlayer()} won"

    it "says the game is tied when api reports game is tied", ->
      prompt = $(".prompt")
      api = new MockAPI(gameState: "tied")
      game = Game.newGame(api)
      view = new GameView(game)

      expect(prompt.text()).toContain game.currentPlayer

      $("#0").click()
      expect(prompt.text()).toContain "tied"
