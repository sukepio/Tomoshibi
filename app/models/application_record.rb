class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time
    start.strftime("%H:%M")
  end

  def time_format
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    created_at.strftime("%-m/%-d(#{wd[created_at.wday]})")
  end
  
  def date_format
    '%Y/%-m/%-d'
  end

  def birthday
    date_of_birth.strftime(date_format)
  end

  def age
    (Date.today.strftime(date_format).to_i - birthday.to_i)
  end
end
