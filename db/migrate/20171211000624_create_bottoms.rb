class CreateBottoms < ActiveRecord::Migration[5.1]
  def change
    create_table :bottoms do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.references :weather_type, foreign_key: true
      t.references :bottom_type, foreign_key: true
      t.references :style_type, foreign_key: true
      t.string :picture
      t.boolean :favorite
      t.boolean :active

      t.timestamps
    end
  end
end
