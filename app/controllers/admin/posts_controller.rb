class Admin::PostsController < ApplicationController


  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "避難所通信「#{@post.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post =Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "避難所通信「#{@post.title}」を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
