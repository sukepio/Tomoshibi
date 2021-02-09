class Admin::MealsController < ApplicationController
  before_action :set_meal, only: [:edit, :update, :destroy]

  def index
    @meals = Meal.all
    @meal = Meal.new
    @today_meals =Meal.where(start: Time.now.in_time_zone("Tokyo").all_day)
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to admin_meals_path, notice: "「#{@meal.menu}」を追加しました。"
    else
      render :index
    end
  end

  def edit

  end

  def update
    if @meal.update(meal_params)
      redirect_to admin_meals_path, notice: "「#{@meal.menu}」を更新しました。"
    else
      render :index
    end
  end

  def destroy
    @meal.destroy
    redirect_to admin_meals_path, notice: "「#{@meal.menu}」を削除しました。"
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:menu, :amount, :detail, :start)
  end
end
