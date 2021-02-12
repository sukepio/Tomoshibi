class Public::PostsController < ApplicationController

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end
end
