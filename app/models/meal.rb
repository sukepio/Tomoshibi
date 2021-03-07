class Meal < ApplicationRecord
  validates :menu, presence: true
  validates :amount, presence: true
  validates :start, presence: true

  def time_format
    start.strftime('%H:%M')
  end
  
  scope :for_today, -> { where(start: Time.now.in_time_zone("Tokyo").all_day) }
end
