class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  # dealerPlay: -> 
  #   console.log 'dealer is playing'
  #   debugger
  #   console.log @app

    # flip hidden dealer card
    # if soft 17 or lower, dealer hits
    # else scores are calculated