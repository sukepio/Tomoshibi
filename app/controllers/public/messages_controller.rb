class Public::MessagesController < ApplicationController
  before_action :authenticate_resident!

  def index
    @messages = Message.page(params[:page]).per(9).order(created_at: :desc)
  end
end
