class TicTacToeAPI
  constructor: (@rootURL) ->

  setErrorHandler: (@errorHandler) ->

  targetURL: (game) ->
    "#{@rootURL}?current_player=#{game.currentPlayer}&board=#{game.board.join()}"

  updateGame: (game, successHandler) ->
    $.ajax
      url: @targetURL(game)
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        successHandler(data)
      error: (jqXHR, textStatus, errorMessage) =>
        @errorHandler()

this.TicTacToeAPI = TicTacToeAPI
