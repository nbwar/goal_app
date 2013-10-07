class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      flash[:notice] = "Goal Created"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
    def goal_params
      params.require(:goal).permit(:title, :description)
    end

end
