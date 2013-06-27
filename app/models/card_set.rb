class CardSet < ActiveRecord::Base
  has_many :card_versions
  has_many :cards, through: :card_versions
end
