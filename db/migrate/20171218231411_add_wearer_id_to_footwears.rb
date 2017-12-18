class AddWearerIdToFootwears < ActiveRecord::Migration[5.1]
  def change
    add_column :footwears, :wearer_id, :integer
  end
end
