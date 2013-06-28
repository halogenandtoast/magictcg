class CardSetsController < ApplicationController
  def show
    # TODO: Make this loads better
    @card_set = CardSet.find(params[:id])
    @card_versions = @card_set.card_versions
    @collected_card_versions = current_user.collected_cards.includes(:card_version).where(card_version_id: @card_versions.map(&:id)).map(&:card_version)
    @uncollected_card_versions = @card_versions.reject { |version| @collected_card_versions.include?(version) }.sort { |a, b| a.card.name <=> b.card.name }
  end
end
