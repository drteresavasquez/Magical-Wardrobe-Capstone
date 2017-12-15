class AddFamilyNameToFamilies < ActiveRecord::Migration[5.1]
  def change
    add_column :families, :family_name, :string
  end
end
