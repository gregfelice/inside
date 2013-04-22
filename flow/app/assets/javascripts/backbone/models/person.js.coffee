class Flow.Models.Person extends Backbone.Model

  paramRoot: 'person'

  defaults:
    id: null
    name: null
    title: null

class Flow.Collections.PeopleCollection extends Backbone.Collection
  model: Flow.Models.Person
  url: '/people'
