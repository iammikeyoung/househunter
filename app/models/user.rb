class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :houses
  has_many :notes

  has_secure_password

  validates :first_name,  presence: true, length: { maximum: 25 }
  validates :last_name,   presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,       presence: true,
                          length: { maximum: 50 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  validates :password,    presence: true,
                          length: { minimum: 8 },
                          allow_nil: true

  def name
    [first_name, last_name].join " "
  end

end
