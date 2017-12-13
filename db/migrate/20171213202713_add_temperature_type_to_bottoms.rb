class AddTemperatureTypeToBottoms < ActiveRecord::Migration[5.1]
  def change
    add_reference :bottoms, :temperature_type, foreign_key: true
  end
end
