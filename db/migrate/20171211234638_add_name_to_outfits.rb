class AddNameToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_column :outfits, :name, :string
  end
end
