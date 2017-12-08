class CreateBottomTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :bottom_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
