class AddZipCodeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :zip_code, :integer
  end
end
