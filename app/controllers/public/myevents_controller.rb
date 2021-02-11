class Public::MyeventsController < ApplicationController

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

  private

  def myevent_params
    params.require(:myevent).permit(:title, :body, :start)
  end
end
