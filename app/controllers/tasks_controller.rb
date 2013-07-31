class TasksController < ApplicationController 
  before_filter :authenticate_user!
  
  def new
    @task = Task.new

    @goal = Goal.find(params[:goal_id])
  end

  def create
    @task = Task.new(params[:task])

    if @task.save!
      if request.xhr?
        render nothing: true
      else
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

  end

  def index

  end

  def show
    
  end

end