class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def time_format
    start.strftime("%H:%M")
  end

end
