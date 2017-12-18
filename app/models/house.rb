class House < ApplicationRecord
  belongs_to :user
  has_many :notes
  mount_uploader :house_profile_pic, HouseProfilePicUploader

  VALID_ZIP_CODE_REGEX = /\d{5}/
  VALID_STATE_REGEX = /[a-zA-Z]{2}/
  validates :name, presence: true, length: { maximum: 25 }, uniqueness: { scope: :user_id }
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2 }, format: { with: VALID_STATE_REGEX }
  validates :zip_code, presence: true, length: { is: 5 }, format: { with: VALID_ZIP_CODE_REGEX }
  validates :asking_amount, numericality: { only_integer: true }, allow_blank: true
  validates :total_sqft, numericality: { only_integer: true }, allow_blank: true
  validate :profile_pic_size

  def address
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
