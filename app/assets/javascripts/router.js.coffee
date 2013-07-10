Tcg.Router.map (match)->
  @resource "collecting_sets", path: "/", ->
    @resource "collecting_set", path: "/collecting_set/:collecting_set_id"

Tcg.CollectingSetsRoute = Ember.Route.extend
  model: -> Tcg.CollectingSet.find()

# Tcg.CollectingSetRoute = Ember.Route.extend
#   model: (params) -> Tcg.CollectingSet.find(params.collecting_set_id)
