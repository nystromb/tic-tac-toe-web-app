class NullAPI
  updateGame: ->

describe "using the tic tac toe web api", ->

  beforeEach ->
    jasmine.Ajax.install()

  afterEach ->
    jasmine.Ajax.uninstall()

  it "generates the target URL from given game state", ->
    api = new TicTacToeAPI("http://domain")
    game = Game.newGame(new NullAPI()).makeMove(0).makeMove(1)
    jasmine.Ajax.stubRequest(api.targetURL(game))
    api.updateGame(game, ->)

    url = jasmine.Ajax.requests.mostRecent().url

    expect(url).toBe "http://domain?current_player=x&board=x,o,_,_,_,_,_,_,_"

  it "applies success callback to response data received from api", ->
    onSuccess = jasmine.createSpy("success handler")
    api = new TicTacToeAPI("http://domain")
    game = Game.newGame(new NullAPI())

    responseData = thisIsJson: "ayep"
    jasmine.Ajax.stubRequest(api.targetURL(game)).andReturn({
      "responseText": JSON.stringify(responseData)
    })

    api.updateGame(game, onSuccess)

    expect(onSuccess).toHaveBeenCalledWith(responseData)

  it "applies error callback when it fails to receive a response from api", ->
    onError = jasmine.createSpy("error handler")
    api = new TicTacToeAPI("http://domain")
    api.setErrorHandler(onError)
    game = Game.newGame(new NullAPI())

    responseData = thisIsJson: "ayep"
    jasmine.Ajax.stubRequest(api.targetURL(game)).andReturn({
      "status": 400
    })

    api.updateGame(game, ->)

    expect(onError).toHaveBeenCalled()
