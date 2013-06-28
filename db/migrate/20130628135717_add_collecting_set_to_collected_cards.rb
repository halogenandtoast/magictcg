class AddCollectingSetToCollectedCards < ActiveRecord::Migration
  def change
    add_column :collected_cards, :collecting_set_id, :integer
    add_index :collected_cards, :collecting_set_id
  end
end
