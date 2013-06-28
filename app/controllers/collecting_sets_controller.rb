class CollectingSetsController < ApplicationController
  respond_to :js

  def create
    card_set = CardSet.find_by(name: params[:set])
    @collecting_set = current_user.collecting_sets.create(card_set: card_set)
    respond_with @collecting_set
  end
end
