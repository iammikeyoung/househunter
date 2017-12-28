class Note < ApplicationRecord
  belongs_to :house
  belongs_to :user

  validates :room, presence: true, uniqueness: { scope: :house_id }
  validates :rating, numericality: { only_integer: true }, inclusion: { in: -1..1 }
  validates :pros, :cons, length: { maximum: 280 }

  def rating_string
    rating_string = ""
    case self.rating
    when 1
      rating_string = "Like"
    when 0
      rating_string = "Neutral"
    when -1
      rating_string = "Dislike"
    end

    rating_string
  end
end
