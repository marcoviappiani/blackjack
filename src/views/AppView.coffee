class window.AppView extends Backbone.View

  className: 'gameBoard'

  template: _.template '
    <div class="player-hand-container clear"></div>
    <div class="dealer-hand-container clear"></div>
    <div class="buttons clear"><button class="hit-button">Hit</button> <button class="stand-button">Stand</button></div>
  '

  events:
    'click .hit-button': -> 
      if !@model.get('gameEnded')
        @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'change:result', @displayResults, @
    @model.checkQuickGame()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  displayResults: ->
    # make sure to disable buttons
    @render()
    console.log @model.get('result');
    action = =>
      alert @model.get('result')
    setTimeout action, 200
    console.log action

      # to add :
        # you win blackjack  (ace and jack)
        # you bust
