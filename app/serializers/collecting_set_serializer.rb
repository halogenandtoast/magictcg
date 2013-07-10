class CollectingSetSerializer < ActiveModel::Serializer
  attributes :id, :card_set_id, :collected_cards_count, :name, :full_count
end
