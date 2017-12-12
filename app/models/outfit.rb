class Outfit < ApplicationRecord
  belongs_to :top
  belongs_to :bottom
  # belongs_to :accessory
  # belongs_to :footwear
  belongs_to :weather_type
  belongs_to :style_type
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validate  :picture_size

  private
  
      # Validates the size of an uploaded picture.
      def picture_size
        if picture.size > 5.megabytes
          errors.add(:picture, "should be less than 5MB")
        end
      end
end
