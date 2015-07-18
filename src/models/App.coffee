# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', @gamePlay, @

    defaults:
      'gameEnded': false

  gamePlay: ->
    if not @get('gameEnded')
      console.log 'we played'
      @get('dealerHand').dealerPlay()
      @set 'gameEnded', true
      # handle results (trigger that it's completed, appview is going tto show a message)
