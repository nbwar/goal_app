class GoalsController < ApplicationController

  def new
    @goal = Goal.new
    @goal.motivations.build
    @goal.actions.build
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      flash[:notice] = "Goal Created"
      redirect_to root_path
    else
      @errors = @goal.errors.full_messages
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
      params.require(:goal).permit(:title, :description, motivations_attributes: [:id, :title, :description, :positive, :_destroy], actions_attributes: [:id, :title, :description, :_destroy])

    end

end
