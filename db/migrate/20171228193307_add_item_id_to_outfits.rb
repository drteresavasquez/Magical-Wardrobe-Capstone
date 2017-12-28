class AddItemIdToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_column :outfits, :item_id, :integer
  end
end
