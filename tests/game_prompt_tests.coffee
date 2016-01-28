describe "game prompt", ->

  makeMoves = (gameState, spaces) ->
    for space in spaces
      gameState = gameState.makeMove(space)
    gameState

  describe "getting a prompt for a given game state", ->

    it "tells the current player it is their turn", ->
      prompt = new GamePrompt()
      newGame = GameState.newGame()

      nextGameState = newGame.makeMove(0)

      expect(prompt.textFor(newGame, "inProgress")).toEqual "It's player x's turn:"
      expect(prompt.textFor(nextGameState, "inProgress")).toEqual "It's player o's turn:"

    it "tells if player x won the game", ->
      prompt = new GamePrompt()

      winningGame = makeMoves(GameState.newGame(), [0, 1, 3, 4, 6])

      expect(prompt.textFor(winningGame, "won")).toEqual "Player x won."

    it "tells if player o won the game", ->
      prompt = new GamePrompt()

      winningGame = makeMoves(GameState.newGame(), [0, 1, 3, 4, 2, 7])

      expect(prompt.textFor(winningGame, "won")).toEqual "Player o won."

    it "tells if player tied the game", ->
      prompt = new GamePrompt()

      tiedGame = makeMoves(GameState.newGame(), [0, 3, 1, 4, 5, 2, 6, 7, 8])

      expect(prompt.textFor(tiedGame, "tied")).toEqual "Y'all tied. Maybe go play another game."
