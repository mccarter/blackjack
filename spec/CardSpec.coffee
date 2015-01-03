assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52

  it "once a card is flipped, it's revealed value is true", ->
    deck = new Deck()
    dealer = deck.dealDealer()
    dealer.models[0].flip()
    assert.strictEqual dealer.models[0].attributes["revealed"], true
