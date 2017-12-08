class AddPictureToTops < ActiveRecord::Migration[5.1]
  def change
    add_column :tops, :picture, :string
  end
end
