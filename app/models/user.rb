class User < ActiveRecord::Base
  has_many :collected_cards
  has_many :collecting_sets
end
