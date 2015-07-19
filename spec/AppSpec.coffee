assert = chai.assert

describe "App Model", ->

  # beforeEach ->

  it "should know when player is dealt blackjack", ->
    app = new App()
    app.set 'playerHand', new Hand [new Card({rank:1,suit:0}), new Card({rank:11,suit:0})]
    console.log app.get('playerHand')
    assert.strictEqual app.playerHasBlackJack(), true
