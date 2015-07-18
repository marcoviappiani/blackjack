class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      if !@model.get('gameEnded')
        @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.on 'change:gameEnded', @displayResults, @

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  displayResults: ->
    @render()
    playerScores = @model.get('playerHand').scores()
    playerScore = if playerScores[1] <=21 then playerScores[1] else playerScores[0]
    dealerScores = @model.get('dealerHand').scores()
    dealerScore = if dealerScores[1] <=21 then dealerScores[1] else dealerScores[0]
    result = "Player: #{playerScore} - Dealer #{dealerScore} - "
    if playerScore == dealerScore or (playerScore > 21 and dealerScore > 21)
      result += "It's a tie!"
    else if playerScore <=21 and (playerScore > dealerScore or dealerScore > 21)
      result += "Player wins"
    else if dealerScore <=21 and (dealerScore > playerScore or playerScore > 21)
      result += "Dealer Wins"
    else
      result += 'you cracked the game! please contact the developers of this game'
    action = ->
      alert result
    setTimeout action, 200
    console.log result

      # to add :
        # you win blackjack  (ace and jack)
        # you bust
