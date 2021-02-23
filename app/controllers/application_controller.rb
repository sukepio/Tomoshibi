class ApplicationController < ActionController::Base
  def today
    wd = ["日", "月", "火", "水", "木", "金", "土"]
    today = Date.today
    @today = today.strftime("%-m/%d(#{wd[today.wday]})")
  end
end
