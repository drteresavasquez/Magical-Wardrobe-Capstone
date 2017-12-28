class AddItemIdToAccessories < ActiveRecord::Migration[5.1]
  def change
    add_column :accessories, :item_id, :integer
  end
end
