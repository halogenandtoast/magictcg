class CollectedCard < ActiveRecord::Base
  belongs_to :card_version
  belongs_to :user
  belongs_to :collecting_set, counter_cache: true
end
