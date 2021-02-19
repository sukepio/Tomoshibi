class Meal < ApplicationRecord

  validates :menu, presence: true
  validates :amount, presence: true
  validates :start, presence: true

  def time_format
    start.strftime('%H:%M')
  end
end
