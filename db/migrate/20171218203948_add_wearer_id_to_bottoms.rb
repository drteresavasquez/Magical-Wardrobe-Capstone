class AddWearerIdToBottoms < ActiveRecord::Migration[5.1]
  def change
    add_column :bottoms, :wearer_id, :integer
  end
end
