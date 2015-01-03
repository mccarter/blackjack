# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @on 'dealerMove', @dealerMove
    @on 'playerMove', @playerMove

  dealerMove: ->
  #get dealer's current score
    dealerScore = @get('dealerHand').scores()[0]
  #while dealer score is less than 17, call hit
    while dealerScore < 17
      @get('dealerHand').hit()
      dealerScore = @get('dealerHand').scores()[0]
      if dealerScore > 21
        @trigger "victory"
        @initialize()
    #after loop, fetch dealer and player scores
    playerScore = @get('playerHand').scores()
    #if player has greater score, alert win
    @get('dealerHand').models[0].flip()
    if playerScore[0] > dealerScore[0] or playerScore[1] > dealerScore[1]
      @trigger "victory"
      @initialize()
    #else, dealer wins
    if playerScore[0] is dealerScore[0] or playerScore[1] is dealerScore[1]
      @trigger "draw"
      @initialize()
    else
      @trigger "loss"
      @initialize()
    #reveal dealer's hand, call flip on first card in dealer hand array

  playerMove: ->
    # check player score at position 0. If scrore is less than 21, enable 'hit'
    if @get('playerHand').scores()[0] < 21
      @get('playerHand').hit()
      if @get('playerHand').scores()[0] > 21
        @trigger "bust"
        @initialize()
     #if the score is = 21, alert "21!" and compare to dealer score
      if @get('playerHand').scores()[0] is 21 or @get('playerHand').scores()[1] is 21
        @dealerMove()
  # else, alert game over. Reset app
    else
      @trigger "bust"
      @initialize()
