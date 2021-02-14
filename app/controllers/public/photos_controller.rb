class Public::PhotosController < ApplicationController
  before_action :authenticate_resident!

  def index
    @photos = current_resident.photos
  end
end
