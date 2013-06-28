class CreateCollectingSets < ActiveRecord::Migration
  def change
    create_table :collecting_sets do |t|
      t.belongs_to :user, index: true
      t.belongs_to :card_set, index: true
      t.integer :collected_cards_count

      t.timestamps
    end
  end
end
