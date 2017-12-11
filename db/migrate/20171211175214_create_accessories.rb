class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.references :weather_type, foreign_key: true
      t.references :accessory_type, foreign_key: true
      t.references :style_type, foreign_key: true
      t.boolean :favorite
      t.string :picture
      t.boolean :active

      t.timestamps
    end
  end
end
