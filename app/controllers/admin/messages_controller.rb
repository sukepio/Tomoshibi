class Admin::MessagesController < ApplicationController
  before_action :set_messages, only: [:index, :create]

  def index
    @message = Message.new
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

  def set_messages
    @messages = Message.page(params[:page]).per(6).order(created_at: :desc)
  end

  def message_params
    params.require(:message).permit(:image, :content, :sender)
  end
end
