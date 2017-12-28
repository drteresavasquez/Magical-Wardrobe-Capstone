class AddItemIdToTops < ActiveRecord::Migration[5.1]
  def change
    add_column :tops, :item_id, :integer
  end
end
