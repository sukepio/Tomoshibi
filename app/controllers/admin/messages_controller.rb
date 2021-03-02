class Admin::MessagesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @messages = Message.page(params[:page]).per(6).order(created_at: :desc)
    @message = Message.new
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to admin_messages_path, notice: "メッセージを追加しました。"
    else
      render :new
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
