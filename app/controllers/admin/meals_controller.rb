class Admin::MealsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :today
  before_action :set_meal, only: [:edit, :update, :destroy]

  def index
    @meals = Meal.all
    @today_meals = @meals.for_today.order(:start)
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to meals_url, notice: "「#{@meal.menu}」を追加しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      redirect_to meals_url, notice: "「#{@meal.menu}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_url, notice: "「#{@meal.menu}」を削除しました。"
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:menu, :amount, :detail, :start)
  end
end
