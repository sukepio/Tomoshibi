class Public::ResidentsController < ApplicationController
  before_action :today

  def show
    @myevents = current_resident.myevents
    @today_events = @myevents.where(start: Time.now.in_time_zone("Tokyo").all_day)
    @recent_post = Post.last
  end

  def confirm

  end
  
  def edit
    
  end

  def update
    if current_resident.update(resident_params)
      redirect_to mypage_path
    end
  end

  private

  def resident_params
    params.require(:resident).permit(:photo_accepted, :self_message)
  end
end
