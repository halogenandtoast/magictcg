class CardSet < ActiveRecord::Base
  has_many :card_versions
  has_many :cards, through: :card_versions
  default_scope { order("name ASC") }

  def self.named(name)
    find_by(name: name)
  end

  def versions name
    card_versions.where(card_id: Card.where("name ILIKE ?", "#{name}"))
  end
end
