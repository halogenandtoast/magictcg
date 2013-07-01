class CollectingSetsController < ApplicationController
  respond_to :js, :html

  def show
    @collecting_set = find_collecting_set
    @card_versions = @collecting_set.card_versions.includes(:card).sort { |a,b| ActiveSupport::Inflector.transliterate(a.name) <=> ActiveSupport::Inflector.transliterate(b.name) }
    @collected_card_versions = current_user.collected_cards.includes(:card_version).where(card_version_id: @card_versions.map(&:id)).map(&:card_version)
  end

  def create
    card_set = CardSet.find_by(name: params[:set])
    @collecting_set = current_user.collecting_sets.create(card_set: card_set)
    respond_with @collecting_set
  end

  def destroy
    find_collecting_set.destroy
    redirect_to root_path, notice: "Set removed"
  end

  private

  def find_collecting_set
    current_user.collecting_sets.find(params[:id])
  end
end
