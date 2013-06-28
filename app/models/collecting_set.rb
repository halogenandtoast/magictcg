class CollectingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :card_set

  def full_count
    card_set.cards.count
  end
end
