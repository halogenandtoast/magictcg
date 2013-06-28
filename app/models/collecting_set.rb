class CollectingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :card_set
  has_many :collected_cards, dependent: :destroy

  delegate :name, to: :card_set

  def full_count
    card_set.cards.count
  end
end
