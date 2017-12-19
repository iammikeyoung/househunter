class Note < ApplicationRecord
  belongs_to :house
  belongs_to :user

  validates :room, presence: true, uniqueness: { scope: :house_id }
  validates :rating, numericality: { only_integer: true }, inclusion: { in: -1..1 }
  validates :pros, :cons, length: { maximum: 280 }

end
