Tcg.CollectingSetsController = Ember.ArrayController.extend
  addCollectingSet: ->
    Tcg.CollectingSet.createRecord(card_set_id: @get('cardSetId'))
