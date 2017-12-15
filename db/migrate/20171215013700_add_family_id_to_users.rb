class AddFamilyIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :family_id, :integer
  end
end
