class AddItemIdToBottoms < ActiveRecord::Migration[5.1]
  def change
    add_column :bottoms, :item_id, :integer
  end
end
