class GameView
  constructor: () ->

  update: (game, status) ->
    $('.unmarked-space').html(game.otherPlayer())
    $('.unmarked-space').toggleClass("unmarked-space marked-space")
    
this.GameView = GameView
