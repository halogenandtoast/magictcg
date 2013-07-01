class MoveRarityToCardVersions < ActiveRecord::Migration
  def up
    remove_column :cards, :rarity
    add_column :card_versions, :rarity, :string
  end
  def down
    remove_column :card_versions, :rarity
    add_column :cards, :rarity, :string
  end
end
