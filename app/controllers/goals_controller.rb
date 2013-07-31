class GoalsController < ApplicationController 
  before_filter :authenticate_user!
  
  def new
    @goal = Goal.new

    if request.xhr? 
      render partial: "add_goal", locals: {goal_counter: params[:goal_counter]}
    else
      render :new
    end
  end

  def create
    @goal = Goal.new(params[:goal])

    if @goal.save!
      if request.xhr?
        render partial: "goal_unit", locals: {goal: @goal}
      else
        flash[:notice] = "New goal added!"
        redirect_to root_url
      end
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy

    if request.xhr? 
      render nothing: true
    else
      redirect_to root_url
    end
  end

  def index
    @goals = Goal.where(user_id: current_user.id)
  end

  def show

  end

end