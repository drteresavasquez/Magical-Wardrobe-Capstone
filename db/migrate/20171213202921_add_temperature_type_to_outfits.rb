class AddTemperatureTypeToOutfits < ActiveRecord::Migration[5.1]
  def change
    add_reference :outfits, :temperature_type, foreign_key: true
  end
end
