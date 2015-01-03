assert = chai.assert

describe 'Game', ->
  deck = null
  hand = null


  describe "BlackJack bj", ->
    it "should create hanlde when a user busts", ->
      black = new AppView(model: new App())
      black.model.get('playerHand').models[0] = 10
      black.model.get('playerHand').models[1] = 10
      black.model.get('playerHand').models[2] = 10
      console.log black
      assert.strictEqual black.model.get('playerHand').scores()[0], 30


