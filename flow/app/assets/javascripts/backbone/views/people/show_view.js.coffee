Flow.Views.People ||= {}

class Flow.Views.People.ShowView extends Backbone.View
  template: JST["backbone/templates/people/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
