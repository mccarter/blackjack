assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      hand.hit()
      assert.strictEqual deck.length, 49

  describe 'Dealers first card is turned over', ->
    it 'should have a value of 0', ->
      dealer = deck.dealDealer()
      assert.strictEqual dealer.models[0].attributes['revealed'], false




