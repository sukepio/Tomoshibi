class Public::ResidentsController < ApplicationController
  def show
    @myevents = current_resident.myevents
    @today_events = @myevents.where(start: Time.now.in_time_zone("Tokyo").all_day)
  end
end
