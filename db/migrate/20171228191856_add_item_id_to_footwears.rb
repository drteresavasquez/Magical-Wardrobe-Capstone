class AddItemIdToFootwears < ActiveRecord::Migration[5.1]
  def change
    add_column :footwears, :item_id, :integer
  end
end
