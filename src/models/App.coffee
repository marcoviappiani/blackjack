# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    console.log @get('playerHand').at(0)
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', @gamePlay, @

    defaults:
      'gameEnded': false
      'result' : ''

  gamePlay: ->
    if not @get('gameEnded')
      console.log 'we played'
      @get('dealerHand').dealerPlay()
      @computeResults()
      # handle results (trigger that it's completed, appview is going tto show a message)

  playerHasBlackJack: ->
    console.log "checking if blackjack"
    @get('playerHand').scores()[1] == 21

  checkQuickGame: ->
    if @playerHasBlackJack()
      console.log 'Blackjack - we should close the game'
      @get('dealerHand').dealerFlip()
      @computeResults()

  computeResults: ->
    playerScores = @.get('playerHand').scores()
    playerScore = if playerScores[1] <=21 then playerScores[1] else playerScores[0]
    dealerScores = @.get('dealerHand').scores()
    dealerScore = if dealerScores[1] <=21 then dealerScores[1] else dealerScores[0]
    result = "Player: #{playerScore} - Dealer #{dealerScore} - "
    if playerScore > 21 and @get('playerHand').length > 2
      result += "You bust!"
    else if playerScore == dealerScore or (playerScore > 21 and dealerScore > 21)
      result += "It's a tie!"
    else if playerScore <=21 and (playerScore > dealerScore or dealerScore > 21)
      result += "Player wins"
    else if dealerScore <=21 and (dealerScore > playerScore or playerScore > 21)
      result += "Dealer Wins"
    else
      result += 'you cracked the game! please contact the developers of this game'
    @set 'result', result
    @set 'gameEnded', true
