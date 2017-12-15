class CreateFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :families do |t|
      t.references :user, foreign_key: true
      t.boolean :admin
      t.integer :family_id

      t.timestamps
    end
  end
end
