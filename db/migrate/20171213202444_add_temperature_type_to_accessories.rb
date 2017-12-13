class AddTemperatureTypeToAccessories < ActiveRecord::Migration[5.1]
  def change
    add_reference :accessories, :temperature_type, foreign_key: true
  end
end
