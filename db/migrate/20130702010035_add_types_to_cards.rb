class AddTypesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :types, :string
  end
end
