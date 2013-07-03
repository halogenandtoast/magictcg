class AddMultiverseIdToCardVersion < ActiveRecord::Migration
  def change
    add_column :card_versions, :multiverse_id, :string
  end
end
