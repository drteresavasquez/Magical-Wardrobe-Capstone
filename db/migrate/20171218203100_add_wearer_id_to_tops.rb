class AddWearerIdToTops < ActiveRecord::Migration[5.1]
  def change
    add_column :tops, :wearer_id, :integer
  end
end
