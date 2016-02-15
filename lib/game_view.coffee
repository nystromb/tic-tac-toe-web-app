class GameView
  constructor: (@game) ->
    @prompt = new GamePrompt()
    @updatePrompt("inProgress")
    @enableBoardInput()

  handlePlayerMove: (event) =>
    selectedSpace = $(event.target)
    if @game.spaceIsAvailable(selectedSpace.data("space-id"))
      @markSpace(selectedSpace)
      @disableBoardInput()
      @game.handleTurn(selectedSpace.data("space-id"), @handleComputerTurn)

  handleComputerTurn: (apiResponse) =>
    if apiResponse.gameState is "inProgress"
      @markSpace($("[data-space-id=#{apiResponse.bestMove}]"))
      @game.handleTurn(apiResponse.bestMove, @updateView)
    else
      @updateView(apiResponse)

  updateView: (apiResponse) =>
    @updatePrompt(apiResponse.gameState)
    @enableBoardInput() if apiResponse.gameState is "inProgress"

  markSpace: (space) ->
    space.attr("data-status", "marked")
    space.html(@game.currentPlayer)

  disableBoardInput: ->
    $("[data-status=unmarked]").off()

  enableBoardInput: ->
    $("[data-status=unmarked]").on("click", @handlePlayerMove)

  updatePrompt: (gameStatus) ->
    $(".prompt").text(@prompt.textFor(@game, gameStatus))

this.GameView = GameView
