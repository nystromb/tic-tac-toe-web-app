class NullAPI
  updateGame: ->

describe "game prompt", ->

  makeMoves = (game, spaces) ->
    game.makeMove(space) for space in spaces
    game

  describe "getting a prompt for a given game state", ->

    it "tells the current player it is their turn", ->
      prompt = new GamePrompt()
      game = Game.newGame(new NullAPI())

      expect(prompt.textFor(game, "inProgress")).toEqual "It's player x's turn:"
      expect(prompt.textFor(game.makeMove(0), "inProgress")).toEqual "It's player o's turn:"
      expect(prompt.textFor(game.makeMove(1), "inProgress")).toEqual "It's player x's turn:"

    it "tells if player x won the game", ->
      prompt = new GamePrompt()

      winningGame = makeMoves(Game.newGame(new NullAPI()), [0, 1, 3, 4, 6])

      expect(prompt.textFor(winningGame, "won")).toEqual "Player x won."

    it "tells if player o won the game", ->
      prompt = new GamePrompt()

      winningGame = makeMoves(Game.newGame(new NullAPI()), [0, 1, 3, 4, 2, 7])

      expect(prompt.textFor(winningGame, "won")).toEqual "Player o won."

    it "tells if player tied the game", ->
      prompt = new GamePrompt()

      tiedGame = makeMoves(Game.newGame(new NullAPI()), [0, 3, 1, 4, 5, 2, 6, 7, 8])

      expect(prompt.textFor(tiedGame, "tied")).toEqual "Y'all tied. Maybe go play another game."
