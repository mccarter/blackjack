# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @on 'dealerMove', @dealerMove, this
    @on 'playerMove', @playerMove, this
    if @get('playerHand').scores()[1] is 21
      @trigger "victory"
    @on 'new-game', @newGame, this

  newGame: ->
    oldDeck = @get 'deck'
    console.log 'oldDeck', oldDeck
    if oldDeck.length <= 4
      @set 'deck', deck = new Deck()
    # @set 'deck', deck = new Deck()
      console.log 'newDeck', deck
      @set 'playerHand', deck.dealPlayer()
      @set 'dealerHand', deck.dealDealer()
    @set 'playerHand', oldDeck.dealPlayer()
    @set 'dealerHand', oldDeck.dealDealer()

  dealerMove: ->
  #get dealer's current score. We need to flip the card to access it's value
    @get('dealerHand').models[0].flip()
    dealerScores = @get('dealerHand').scores()
  #while dealer score is less than 17, call hit
    while dealerScores[0] < 17
      @get('dealerHand').hit()
      dealerScores = @get('dealerHand').scores()
      if dealerScores[0] > 21
        @trigger "victory"
        # return @newGame()
      if dealerScores[0] is 21 or dealerScores[1] is 21
        @trigger "loss"
        # return @newGame()

    #after loop, fetch dealer and player scores
    playerScores = @get('playerHand').scores()
    #if player has greater score, alert win
    #@get('dealerHand').models[0].flip()
    if playerScores[0] > dealerScores[0]
      @trigger "victory"
      # return @newGame()
    #else, dealer wins
    if playerScores[0] is dealerScores[0]
      @trigger "draw"
      # return @newGame()
    if playerScores[0] < dealerScores[0]
      @trigger "loss"
      # return @newGame()
    #reveal dealer's hand, call flip on first card in dealer hand array

  playerMove: ->
    # check player score at position 0. If scrore is less than 21, enable 'hit'
    if @get('playerHand').scores()[0] < 21
      @get('playerHand').hit()
      if @get('playerHand').scores()[0] > 21
        @trigger "bust"
        # return @newGame()
     #if the score is = 21, alert "21!" and compare to dealer score
      if @get('playerHand').scores()[0] is 21 or @get('playerHand').scores()[1] is 21
        return @dealerMove()
  # else, alert game over. Reset app
    else
      @trigger "bust"
      # return @newGame()
