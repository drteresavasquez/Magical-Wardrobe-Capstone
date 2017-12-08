class Top < ApplicationRecord
  belongs_to :user
  belongs_to :weather_type
  belongs_to :top_type
  belongs_to :style_type
end
