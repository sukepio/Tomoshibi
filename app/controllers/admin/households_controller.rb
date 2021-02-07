class Admin::HouseholdsController < ApplicationController
  def new
    @resident = Resident.find(params[:resident_id])
    @household = Household.new
    @household.head_id = @resident.id
  end

  def create
    @resident = Resident.find(params[:resident_id])
    @household = Household.new(household_params)
    @household.head_id = @resident.id

    if @household.save
      @resident.update(household_id: @household.id)
      redirect_to admin_resident_path(@resident), notice: "#{@resident.full_name}さんの世帯情報を登録しました。"
    else
      render :new
    end
  end

  def update
  end

  private

  def household_params
    params.require(:household).permit(:head_id, :address, :living_space, :house_damage_situation)
  end
end
