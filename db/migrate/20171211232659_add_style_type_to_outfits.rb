class AddStyleTypeToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_reference :outfits, :style_type, foreign_key: true
  end
end
