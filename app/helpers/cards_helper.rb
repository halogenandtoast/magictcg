module CardsHelper
  def card_data(card_version)
    {
      name: card_version.name.downcase,
      color: card_version.color,
      rarity: card_version.rarity,
      type: card_version.types
    }
  end
end
