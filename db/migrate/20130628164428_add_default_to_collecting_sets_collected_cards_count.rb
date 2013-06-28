class AddDefaultToCollectingSetsCollectedCardsCount < ActiveRecord::Migration
  def change
    change_column_default :collecting_sets, :collected_cards_count, 0
  end
end
