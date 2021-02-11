class Admin::ResidentsController < ApplicationController

  def index
    @q = Resident.ransack(params[:q])
    @households = Household.all
    @residents = @q.result.includes(:household)
  end

  def show
    @resident = Resident.find(params[:id])

    if @resident.household.present?
      @household = @resident.household
      @residents = @household.residents
    end

  end

  def edit
    @resident = Resident.find(params[:id])
    @households = Household.all
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
    params.require(:resident).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :login_id, :date_of_birth, :gender, :information, :household_id, :has_left)
  end

  def search_params
    params.require(:q).permit(:last_name_cont, :household_id_eq)
  end
end
