# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @on 'dealerCheck', @dealerCheck

  dealerCheck: ->
  #get dealer's current score
    dealerScore = @get('dealerHand').scores()[0]
  #while dealer score is less than 17, call hit
    while dealerScore < 17
      @get('dealerHand').hit()
      dealerScore = @get('dealerHand').scores()[0]
      if dealerScore > 21
        alert "You win!"
    #after loop, fetch dealer and player scores
    playerScores = @get('playerHand').scores()
    #if player has greater score, alert win
    if playerScores[0] > dealerScore[0] or playerScores[1] > dealerScore[1]
      alert "You win!"
    #else, dealer wins
    else alert "Dealer wins!"
    #reveal dealer's hand, call flip on first card in dealer hand array
    @get.dealerHand[0].flip()
