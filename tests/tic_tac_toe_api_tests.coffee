describe "using the tic tac toe web api", ->

  beforeEach ->
    jasmine.Ajax.install()

  afterEach ->
    jasmine.Ajax.uninstall()

  it "generates the target URL from given game state", ->
    api = new TicTacToeAPI("http://domain")
    gameState = GameState.newGame().makeMove(0).makeMove(1)
    onSuccess = jasmine.createSpy("success handler")
    jasmine.Ajax.stubRequest(api.gameStateURL(gameState))
    api.getAPIGameState(gameState, onSuccess)

    url = jasmine.Ajax.requests.mostRecent().url

    expect(url).toBe "http://domain?current_player=x&board=x,o,_,_,_,_,_,_,_"


  it "applies callback to json response data from api on success", ->
    api = new TicTacToeAPI("http://domain")
    gameState = GameState.newGame()
    onSuccess = jasmine.createSpy("success handler")
    responseData = thisIsJson: "ayep"
    jasmine.Ajax.stubRequest(api.gameStateURL(gameState)).andReturn({
      "responseText": JSON.stringify(responseData)
    })

    api.getAPIGameState(gameState, onSuccess)

    expect(onSuccess).toHaveBeenCalledWith(responseData)
