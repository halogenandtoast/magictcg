class CollectedCardsController < ApplicationController
  respond_to :json

  def create
    collected_card = current_user.collected_cards.create(collected_card_params)
    respond_with collected_card
  end

  private

  def collected_card_params
    {
      card_version_id: params[:card_version_id]
    }
  end
end
