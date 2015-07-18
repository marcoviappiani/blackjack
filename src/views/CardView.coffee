class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'
  templateC: _.template '<img src="img/card-back.png">'

  initialize: -> 
    @render()
    @on 'change:revealed', @render(), @

  render: ->
    @$el.children().detach()
    if @model.get('revealed')
      @$el.html @template @model.attributes
      # @$el.addClass 'covered' unless @model.get 'revealed'
    else
      @$el.html @templateC

