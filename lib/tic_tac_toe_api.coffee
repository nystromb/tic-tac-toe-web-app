class TicTacToeAPI
  constructor: (@rootURL) ->

  gameStateURL: (gameState) ->
    "#{@rootURL}?current_player=#{gameState.currentPlayer}&board=#{gameState.board.join()}"

  getAPIGameState: (gameState, onSuccess) ->
    $.ajax
      url: @gameStateURL(gameState)
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        onSuccess(data)

this.TicTacToeAPI = TicTacToeAPI
