class AddWearerIdToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_column :outfits, :wearer_id, :integer
  end
end
