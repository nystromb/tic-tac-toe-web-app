describe "using the tic tac toe web api", ->

  beforeEach ->
    jasmine.Ajax.install()

  afterEach ->
    jasmine.Ajax.uninstall()

  it "generates the target URL from given game state", ->
    api = new TicTacToeAPI("http://domain", ->)
    game = Game.newGame().makeMove(0).makeMove(1)
    jasmine.Ajax.stubRequest(api.targetURL(game))
    api.updateGame(game)

    url = jasmine.Ajax.requests.mostRecent().url

    expect(url).toBe "http://domain?current_player=x&board=x,o,_,_,_,_,_,_,_"


  it "applies callback to json response data from api on success", ->
    onSuccess = jasmine.createSpy("success handler")
    api = new TicTacToeAPI("http://domain", onSuccess)
    game = Game.newGame()

    responseData = thisIsJson: "ayep"
    jasmine.Ajax.stubRequest(api.targetURL(game)).andReturn({
      "responseText": JSON.stringify(responseData)
    })

    api.updateGame(game)

    expect(onSuccess).toHaveBeenCalledWith(responseData)
