class AddOutterwearIdToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_column :outfits, :outterwear_id, :integer
  end
end
