class House < ApplicationRecord
  belongs_to :user
  has_many :notes

  VALID_ZIP_CODE_REGEX = /\d{5}/
  validates :street, :city, :state, :zip_code, presence: true
  validates :zip_code, length: { is: 5 }, format: { with: VALID_ZIP_CODE_REGEX }

  def full_address
    [street, city, state, zip_code].join(' ')
  end
end