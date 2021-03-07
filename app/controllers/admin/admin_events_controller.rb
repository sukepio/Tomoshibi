class Admin::AdminEventsController < ApplicationController
  before_action :authenticate_admin!
  before_action :today
  before_action :set_admin_event, only: [:edit, :update, :destroy]
  before_action :set_index, only: [:index, :create]

  def index
    @admin_events = AdminEvent.all
  end

  def new
    @admin_event = AdminEvent.new
  end

  def create
    @admin_event = AdminEvent.new(admin_event_params)
    if @admin_event.save
      redirect_to admin_events_path, notice: "「#{@admin_event.title}」を作成しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @admin_event.update(admin_event_params)
      redirect_to admin_events_path, notice: "「#{@admin_event.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @admin_event.destroy
    redirect_to admin_events_path, notice: "「#{@admin_event.title}」を削除しました。"
  end

  private

  def set_index
    @residents = Resident.where(has_left: false)
    @households = Household.all
    @today_events = AdminEvent.for_today.order(:start)
    @men = @residents.woman
    @women = @residents.woman
  end

  def set_admin_event
    @admin_event = AdminEvent.find(params[:id])
  end

  def admin_event_params
    params.require(:admin_event).permit(:title, :body, :start, :end)
  end
end
