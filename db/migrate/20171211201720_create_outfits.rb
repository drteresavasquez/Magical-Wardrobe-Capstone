class CreateOutfits < ActiveRecord::Migration[5.1]
  def change
    create_table :outfits do |t|
      t.references :top, foreign_key: true
      t.references :bottom, foreign_key: true
      t.references :accessory, foreign_key: true
      t.references :footwear, foreign_key: true
      t.references :weather_type, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :active
      t.boolean :favorite
      t.string :picture

      t.timestamps
    end
  end
end
