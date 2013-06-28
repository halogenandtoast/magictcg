class CollectedCardsController < ApplicationController
  respond_to :js

  def create
    @collected_card = current_user.collected_cards.create(collected_card_params)
    respond_with @collected_card
  end

  private

  def collected_card_params
    {
      card_version_id: card_version.id,
      collecting_set_id: collecting_set.id
    }
  end

  def card_version
    @_card_version ||= CardVersion.find(params[:card_version_id])
  end

  def collecting_set
    @_collecting_set ||= CollectingSet.find_by(card_set_id: card_version.card_set_id)
  end
end
