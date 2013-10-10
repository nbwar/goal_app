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

  def show_goal
    goal = Goal.find(params["goal"])
    render :json => render_to_string(:partial => "large_goal", :locals => {goal: goal} ).to_json
  end

  def add_goal_detail
    goal = Goal.find(params["goal"])
    object = goal.send(params["klass"].pluralize).create(title: params["title"], description: params["description"])
    if object.attributes.include?('positive')
      object.update_attributes(positive: params["positive"])
      object.save
    end
    render :json => render_to_string(:partial => "goal_attribute", :locals => { object: object }).to_json
  end

  def edit_object
    object = params["klass"].constantize.find(params["object"])
    object.update_attributes(title: params["title"], description: params["description"])
    object.save
    render :json => render_to_string(:partial => "goal_attribute", :locals => { object: object }).to_json
  end

  def destroy
  end

  private
    def goal_params
      params.require(:goal).permit(:title, :description, motivations_attributes: [:id, :title, :description, :positive, :_destroy], actions_attributes: [:id, :title, :description, :_destroy])
    end
end
