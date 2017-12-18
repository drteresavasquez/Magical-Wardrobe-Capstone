class AddWearerIdToAccessories < ActiveRecord::Migration[5.1]
  def change
    add_column :accessories, :wearer_id, :integer
  end
end
