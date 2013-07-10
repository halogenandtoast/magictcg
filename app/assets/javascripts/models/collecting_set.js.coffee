Tcg.CollectingSet = DS.Model.extend
  card_set_id: DS.attr('number')
  collected_cards_count: DS.attr('number')
  full_count: DS.attr('number')
  name: DS.attr('string')
