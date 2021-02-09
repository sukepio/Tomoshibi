class Admin::MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = Message.page(params[:page]).per(6)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to admin_messages_path, notice: "メッセージを追加しました。"
    else
      render :index
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to admin_messages_path, notice: "メッセージを削除しました。"
  end

  private

  def message_params
    params.require(:message).permit(:image, :content, :sender)
  end
end
