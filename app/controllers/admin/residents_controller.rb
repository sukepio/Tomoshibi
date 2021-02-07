class Admin::ResidentsController < ApplicationController

  def index
    @residents = Resident.all
  end

  def show
    @resident = Resident.find(params[:id])
    
    if @resident.household.present?
      @household = @resident.household
    end
    
  end

  def edit
    @resident = Resident.find(params[:id])
  end

  def update
    @resident = Resident.find(params[:id])
    if @resident.update(resident_params)
      redirect_to admin_resident_path(@resident), notice: "#{@resident.full_name}さんの情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def resident_params
    params.require(:resident).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :login_id, :date_of_birth, :gender, :information)
  end
end
