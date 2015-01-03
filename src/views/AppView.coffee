class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': ->
      @model.trigger('playerMove')

    'click .stand-button': ->
      #call dealer check when the stand button is clicked. Dealer check
      @model.trigger('dealerMove')

    'click .new-game': ->
      @model.trigger('new-game')

  initialize: ->
    @render()
    @model.on 'change', @render, @
    @model.on 'bust', ->
         # debugger
        @render()
        alert "BUST!"
      , @

    @model.on 'victory', ->
         # debugger
        @render()
        alert "VICTORY!"
      , @

    @model.on 'draw', ->
         # debugger
        @render()
        alert "draw"
      , @

    @model.on 'loss', ->
         # debugger
        @render()
        alert "You lose!"
      , @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

