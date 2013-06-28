class CreateCollectedCards < ActiveRecord::Migration
  def change
    create_table :collected_cards do |t|
      t.belongs_to :card_version, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
