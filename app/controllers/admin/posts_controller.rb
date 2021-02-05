class Admin::PostsController < ApplicationController


  def index
    @posts = Post.all
  end
  def new
    @post = Post.new
  end

  def create
    @post = current_admin.posts.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: "避難所通信「#{@post.title}」を投稿しました。"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
