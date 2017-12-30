class CreateOutterwearTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :outterwear_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
