class Meal < ApplicationRecord

  def time_format
    start.strftime('%H:%M')
  end
end
