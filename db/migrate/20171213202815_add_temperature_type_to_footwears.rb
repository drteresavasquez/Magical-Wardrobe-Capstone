class AddTemperatureTypeToFootwears < ActiveRecord::Migration[5.1]
  def change
    add_reference :footwears, :temperature_type, foreign_key: true
  end
end
