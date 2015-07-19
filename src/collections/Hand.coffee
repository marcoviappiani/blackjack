class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if !@isDealer
      if @scores()[0] >= 21 or @scores()[1] == 21
        @stand()
      

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


  stand: ->
    console.log 'we stood'
    @trigger 'stand'

  dealerPlay: ->
    console.log 'dealer is playing'
    @dealerFlip()
    @hit() while @scores()[1] < 17 or @scores()[0] <17

  dealerFlip: ->
    @at(0).flip()

