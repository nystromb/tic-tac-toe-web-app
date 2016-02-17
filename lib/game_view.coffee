class GameView
  constructor: (@game) ->
    @game.api.setErrorHandler(@handleComputerMoveFailure)
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

  handleComputerMoveFailure: ->
    $("#alerts").html(
      '<div class="alert alert-danger" role="alert">' +
      "The application failed to receive a move from the computer player. " +
      "Refresh the page to try again." +
      '</div>')

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
