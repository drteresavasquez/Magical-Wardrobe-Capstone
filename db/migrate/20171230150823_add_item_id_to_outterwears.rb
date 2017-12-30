class AddItemIdToOutterwears < ActiveRecord::Migration[5.1]
  def change
    add_column :outterwears, :item_id, :integer
  end
end
