class AddWearerIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :wearer_id, :integer
  end
end
