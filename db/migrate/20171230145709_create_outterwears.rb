class CreateOutterwears < ActiveRecord::Migration[5.1]
  def change
    create_table :outterwears do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.references :temperature_type, foreign_key: true
      t.references :weather_type, foreign_key: true
      t.references :outterwear_type, foreign_key: true
      t.references :style_type, foreign_key: true
      t.string :description
      t.boolean :favorite
      t.string :picture
      t.boolean :active

      t.timestamps
    end
  end
end
