class Admin::AdminEventsController < ApplicationController

  def index
    @admin_events = AdminEvent.all
    @admin_event = AdminEvent.new
  end

  def create
    @admin_event = AdminEvent.new(admin_event_params)
    if @admin_event.save
      redirect_to admin_events_path
    else
      render :index
    end
  end




  private

  def admin_event_params
    params.require(:admin_event).permit(:title, :body, :start, :end)
  end
end
