class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.trigger('playerMove')

    'click .stand-button': ->
      #call dealer check when the stand button is clicked. Dealer check
      @model.trigger('dealerMove')

  initialize: ->
    @render()
    @model.on 'change', @render, @
    @model.on 'bust', ->
        alert "BUST!"
        @render()
      , @

    @model.on 'victory', ->
        alert "VICTORY!"
        @render()
      , @

    @model.on 'draw', ->
        alert "draw"
        @render()
      , @

    @model.on 'loss', ->
        alert "You lose!"
        @render()
      , @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

