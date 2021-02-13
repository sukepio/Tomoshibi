class Public::MessagesController < ApplicationController

  def index
    @messages = Message.page(params[:page]).per(9).order(created_at: :desc)
  end
end
