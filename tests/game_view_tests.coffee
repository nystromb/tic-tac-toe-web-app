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

  describe "marking the board", ->

    beforeEach ->
      setFixtures('<td id="0" class="unmarked-space">_</td>' +
        '<td id="1" class="unmarked-space">_</td>')

    it "marks the element with the current player's mark", ->
      boardSpace = $("#0")
      game = Game.newGame(new MockAPI(""))
      view = new GameView(game)
      expectedMark = game.currentPlayer

      boardSpace.click()

      expect(boardSpace.html()).toEqual expectedMark
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

      expect(firstBoardSpace.html()).toEqual expectedMark
      expect(secondBoardSpace.html()).toEqual PlayerMark.NONE

    it "reenables marking spaces after updating game", ->
      firstBoardSpace = $("#0")
      secondBoardSpace = $("#1")
      api = new ManualTriggerMockAPI("")
      game = Game.newGame(api)
      view = new GameView(game)

      firstBoardSpace.click()
      api.triggerGameUpdate()
      expectedMark = game.currentPlayer
      secondBoardSpace.click()

      expect(secondBoardSpace.html()).toEqual expectedMark

  describe "updating the game prompt", ->

    beforeEach ->
      @fixture = setFixtures('<h3 class="prompt">foo</h3>' +
        '<table><tr><td id="0" class="unmarked-space">_</td>' +
        '<td id="1" class="unmarked-space">_</td></tr></table>')

    it "displays the current player's turn when api reports the game is in progress", ->
      prompt = $(".prompt")
      api = new MockAPI(gameState: "inProgress")
      game = Game.newGame(api)
      view = new GameView(game)

      expect(prompt.html()).toContain game.currentPlayer

      $("#0").click()
      expect(prompt.html()).toContain game.currentPlayer

      $("#1").click()
      expect(prompt.html()).toContain game.currentPlayer

    it "says that the previous player won when api reports game has been won", ->
      prompt = $(".prompt")
      api = new MockAPI(gameState: "won")
      game = Game.newGame(api)
      view = new GameView(game)

      expect(prompt.html()).toContain game.currentPlayer

      $("#0").click()
      expect(prompt.html()).toContain "#{game.otherPlayer()} won"

      $("#1").click()
      expect(prompt.html()).toContain "#{game.otherPlayer()} won"

    it "says the game is tied when api reports game is tied", ->
      prompt = $(".prompt")
      api = new MockAPI(gameState: "tied")
      game = Game.newGame(api)
      view = new GameView(game)

      expect(prompt.html()).toContain game.currentPlayer

      $("#0").click()
      expect(prompt.html()).toContain "tied"
