class CollectingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :card_set
  has_many :collected_cards, dependent: :destroy
  has_many :card_versions, through: :card_set

  delegate :name, to: :card_set

  def full_count
    card_set.cards.count
  end

  def self.alphabetical
    includes(:card_set).order("card_sets.name ASC")
  end
end
