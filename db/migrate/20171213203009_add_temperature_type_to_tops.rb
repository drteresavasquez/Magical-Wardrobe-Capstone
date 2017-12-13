class AddTemperatureTypeToTops < ActiveRecord::Migration[5.1]
  def change
    add_reference :tops, :temperature_type, foreign_key: true
  end
end
