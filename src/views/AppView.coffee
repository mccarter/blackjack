class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
    # check player score at position 0. If scrore is less than 21, enable 'hit'
      if @model.get('playerHand').scores()[0] < 21
        @model.get('playerHand').hit()
       #if the score is = 21, alert "21!" and compare to dealer score
        if @model.get('playerHand').scores()[0] is 21 or @model.get('playerHand').scores()[1] is 21
          alert "21!"
          @model.trigger('dealerCheck')
    # else, alert game over. Reset app
      else
        alert "BUST!"
    'click .stand-button': ->
      #call dealer check when the stand button is clicked. Dealer check
      @model.trigger('dealerCheck')

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

