class CreateFootwearTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :footwear_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
