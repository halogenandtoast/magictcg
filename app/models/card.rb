class Card < ActiveRecord::Base
  has_many :card_versions
  has_many :card_sets, through: :card_versions
end
