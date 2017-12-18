class User < ApplicationRecord
  before_save { self.email = email.downcase }

  has_many :houses
  has_many :notes

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A(?=[^a-zA-Z]*[a-zA-Z])(?=[^0-9]*[0-9])[a-zA-Z0-9]+\z/

  validates :first_name,  presence: true, length: { maximum: 25 }
  validates :last_name,   presence: true, length: { maximum: 25 }
  validates :email,       presence: true,
                          length: { maximum: 50 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  validates :password,    presence: true,
                          length: { minimum: 8 },
                          format: { with: PASSWORD_FORMAT,
                            message: "can only have letters or digits and must have at least one of each" },
                          allow_nil: true

  def name
    [first_name, last_name].join " "
  end

end
