class window.AppView extends Backbone.View
  tagName: 'div'
  className: 'container center',

  template: _.template '
    <button type="button" class="btn btn-success hit-button">Hit Me</button>
    <button type="button" class="btn btn-danger stand-button">Stand</button>
    <button type="button" class="btn btn-warning new-game">New Game</button>

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

