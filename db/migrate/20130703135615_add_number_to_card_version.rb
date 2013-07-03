class AddNumberToCardVersion < ActiveRecord::Migration
  def change
    add_column :card_versions, :number, :string
  end
end
