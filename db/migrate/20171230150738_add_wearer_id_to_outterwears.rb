class AddWearerIdToOutterwears < ActiveRecord::Migration[5.1]
  def change
    add_column :outterwears, :wearer_id, :integer
  end
end
