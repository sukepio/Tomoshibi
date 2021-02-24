class Admin::PhotosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_resident, only: [:index, :new, :create, :destroy]

  def index
    @photos = @resident.photos.order(created_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.resident_id = @resident.id
    if @photo.save
      redirect_to admin_resident_photos_path(@resident), notice: "#{@resident.full_name}の写真を追加しました。"
    else
      render :new
    end
  end

  def destroy
    photos = @resident.photos
    @photo = photos.find(params[:id])
    @photo.delete
    redirect_to admin_resident_photos_path(@resident)
  end

  private

  def set_resident
    @resident = Resident.find(params[:resident_id])
  end

  def photo_params
    if params[:photo].present?
      params.require(:photo).permit({ image: [] })
    else
      params.permit({ image: [] })
    end
  end
end
