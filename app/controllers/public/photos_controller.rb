class Public::PhotosController < ApplicationController

  def index
    @photos = current_resident.photos
  end
end
