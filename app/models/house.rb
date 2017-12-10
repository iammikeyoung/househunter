class House < ApplicationRecord
  belongs_to :user
  has_many :notes
  mount_uploader :house_profile_pic, HouseProfilePicUploader

  VALID_ZIP_CODE_REGEX = /\d{5}/
  validates :street, :city, :state, :zip_code, presence: true
  validates :zip_code, length: { is: 5 }, format: { with: VALID_ZIP_CODE_REGEX }
  validate :profile_pic_size

  def full_address
    [street, city, state, zip_code].join(' ')
  end

  def price_per_sqft
    asking_amount / total_sqft
  end

  private

    # Validates the size of an uploaded house profile picture.
    def profile_pic_size
      if house_profile_pic.size > 5.megabytes
        errors.add(:house_profile_pic, "should be less than 5MB")
      end
    end
end
