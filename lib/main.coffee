$(document).ready ->
  view = new GameView(Game.newGame(new TicTacToeAPI("http://107.170.25.194:5000/api/game_state")))
