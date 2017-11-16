class Note < ApplicationRecord
  belongs_to :house
  belongs_to :user

  validates :room, presence: true
  validates :rating, inclusion: { in: -1..1 }
  validates :pros, :cons, length: { maximum: 280 }

end
