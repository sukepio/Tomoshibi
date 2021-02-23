class Public::MyeventsController < ApplicationController
  before_action :authenticate_resident!
  before_action :set_myevent, only: [:edit, :update, :destroy]

  def new
    @myevent = Myevent.new
  end

  def create
    @myevent = current_resident.myevents.new(myevent_params)
    if @myevent.save
      redirect_to mypage_path, notice: "#{@myevent.title}を追加しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @myevent.update(myevent_params)
      redirect_to mypage_path, notice: "#{@myevent.title}を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @myevent.destroy
    redirect_to mypage_path, notice: "#{@myevent.title}を削除しました。"
  end

  private

  def set_myevent
    @myevent = Myevent.find(params[:id])
  end

  def myevent_params
    params.require(:myevent).permit(:title, :body, :start)
  end
end
