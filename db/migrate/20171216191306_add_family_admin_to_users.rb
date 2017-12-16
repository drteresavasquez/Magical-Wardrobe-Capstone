class AddFamilyAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :family_admin, :boolean
  end
end
