class TicTacToeAPI
  constructor: (@rootURL, @successHandler) ->

  targetURL: (game) ->
    "#{@rootURL}?current_player=#{game.currentPlayer}&board=#{game.board.join()}"

  updateGame: (game) ->
    callback = @successHandler
    $.ajax
      url: @targetURL(game)
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        callback(data)

this.TicTacToeAPI = TicTacToeAPI
