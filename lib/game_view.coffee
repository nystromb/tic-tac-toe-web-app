class GameView
  constructor: (@game) ->
    @prompt = new GamePrompt()
    @updatePrompt("inProgress")
    @enableBoardInput()

  handlePlayerMove: (event) =>
    selectedSpace = event.target
    if @game.spaceIsAvailable(selectedSpace.id)
      @markSpace(selectedSpace)
      @disableBoardInput()
      @game.handleTurn(selectedSpace.id, @updateView)

  updateView: (apiResponse) =>
    @updatePrompt(apiResponse.gameState)
    @enableBoardInput() if apiResponse.gameState is "inProgress"

  markSpace: (space) ->
    $(space).html(@game.currentPlayer)
    $(space).toggleClass("unmarked-space marked-space")

  disableBoardInput: ->
    $(".unmarked-space").off()

  enableBoardInput: ->
    $(".unmarked-space").on("click", @handlePlayerMove)

  updatePrompt: (gameStatus) ->
    $(".prompt").text(@prompt.textFor(@game, gameStatus))

this.GameView = GameView
