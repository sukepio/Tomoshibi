class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_format
    start.strftime("%H:%M")
  end

  def time
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    created_at.strftime("%-m/%-d(#{wd[created_at.wday]})")
  end
end
