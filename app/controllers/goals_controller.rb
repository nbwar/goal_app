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
    @goal = Goal.find(params[:id])
  end

  def show_goal
    goal = Goal.find(params["goal"])
    render :json => render_to_string(:partial => "large_goal", :locals => {goal: goal} ).to_json
  end

  def edit
    @goal = Goal.find(params[:id])
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
