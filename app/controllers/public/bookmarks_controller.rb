class Public::BookmarksController < ApplicationController
  before_action :authenticate_resident!
  before_action :set_post, only: [:create, :destroy]

  def index
    @bookmarks = current_resident.bookmarks.includes([:post])
  end

  def create
    @bookmark = current_resident.bookmarks.new(post_id: @post.id)
    @bookmark.save
    # redirect_to post_path(@post)
  end

  def destroy
    @bookmark = current_resident.bookmarks.find_by(post_id: @post.id)
    @bookmark.destroy
    # redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
