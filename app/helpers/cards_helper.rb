module CardsHelper
  def card_data(card_version)
    data = {
      name: card_version.name.downcase,
      color: card_version.color,
      rarity: card_version.rarity,
      type: card_version.types,
      collect_url: card_version_collected_cards_path(card_version)
    }
    if card = current_user.collected_cards.find_by(card_version_id: card_version)
      data.merge(uncollect_url: card_version_collected_card_path(card_version, card))
    else
      data
    end
  end
end
