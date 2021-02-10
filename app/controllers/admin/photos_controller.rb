class Admin::PhotosController < ApplicationController
  before_action :set_resident, only: [:index, :new, :create, :destroy]

  def index
    @photos = @resident.photos
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = @resident.photos.new(photo_params)
    if @photo.save
      redirect_to admin_resident_photos_path(@resident), notice: "#{@resident.full_name}の写真を追加しました。"
    else
      render :new
    end
  end

  def destroy
    photos = @resident.photos
    @photo = photos.find(params[:id])
    @photo.destroy
    redirect_to admin_resident_photos_path(@resident)
  end


  private

  def set_resident
    @resident = Resident.find(params[:resident_id])
  end

  def photo_params
    params.require(:photo).permit({images: []})
  end
end
