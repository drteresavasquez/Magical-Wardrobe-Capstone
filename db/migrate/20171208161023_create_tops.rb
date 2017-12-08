class CreateTops < ActiveRecord::Migration[5.1]
  def change
    create_table :tops do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.references :weather_type, foreign_key: true
      t.references :top_type, foreign_key: true
      t.references :style_type, foreign_key: true
      t.string :description
      t.boolean :favorite
      t.boolean :active

      t.timestamps
    end
  end
end
