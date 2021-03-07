class Myevent < ApplicationRecord
  belongs_to :resident

  validates :title, presence: true
  validates :resident_id, presence: true

  scope :for_today, -> { where(start: Time.now.in_time_zone("Tokyo").all_day) }
end
