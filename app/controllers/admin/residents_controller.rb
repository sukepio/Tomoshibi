class Admin::ResidentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_resident, only: [:show, :edit, :update]

  def index
    @q = Resident.ransack(params[:q])
    @households = Household.all
    @residents = @q.result.includes(:household).page(params[:page]).per(20)
  end

  def show
    if @resident.household.present?
      @household = @resident.household
      @residents = @household.residents
    end
  end

  def edit
    @households = Household.all
  end

  def update
    @households = Household.all
    if @resident.update(resident_params)
      redirect_to admin_resident_path(@resident), notice: "#{@resident.full_name}さんの情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def set_resident
    @resident = Resident.find(params[:id])
  end

  def resident_params
    params.require(:resident).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :login_id, :date_of_birth, :gender, :information, :household_id, :has_left)
  end

  def search_params
    params.require(:q).permit(:last_name_cont, :household_id_eq)
  end
end
