class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:update, :edit, :show, :destroy]

  def index
    @exercises = current_user.exercises
  end

  def new
    @exercise = current_user.exercises.build
  end

  def create
    @exercise = current_user.exercises.build(exercise_params)
    if @exercise.save
      flash[:notice] = "Exercise has been created"
      redirect_to [current_user, @exercise]
    else
      flash.now[:alert] = "Exercise has not been created"
      render :new
    end
  end

  def show
  end

  def destroy
    if @exercise.destroy
      flash[:notice] = "Exercise has been deleted"
      redirect_to root_path
    else
      flash[:alert] = "Exercise has not been deleted"
      redirect_to [current_user, @exercise]
    end
  end

  private
    def exercise_params
      params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
    end

    def set_exercise
      user = User.find(params[:user_id])
      @exercise = user.exercises.find(params[:id])
    end
end
