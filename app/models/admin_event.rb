require 'concerns/time'

class AdminEvent < ApplicationRecord
  include TimeFormat
  
  validates :title, presence: true
  validates :start, presence: true
  validates :end, presence: true
  
  scope :for_today, -> { where(start: Time.now.in_time_zone("Tokyo").all_day) }
end
