class CardVersion < ActiveRecord::Base
  belongs_to :card_set
  belongs_to :card
end
