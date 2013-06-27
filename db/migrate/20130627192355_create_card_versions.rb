class CreateCardVersions < ActiveRecord::Migration
  def change
    create_table :card_versions do |t|
      t.belongs_to :card_set, index: true
      t.belongs_to :card, index: true
      t.string :image_url

      t.timestamps
    end
  end
end
