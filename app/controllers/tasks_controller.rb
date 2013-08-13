class TasksController < ApplicationController 
  before_filter :authenticate_user!
  
  def new
    @task = Task.new

    @goal = Goal.find(params[:goal_id])

    if request.xhr? 
      task_id = SecureRandom.hex.to_s 
      render partial: "add_task", locals: {task_id: task_id, goal: @goal}
    else
      render :new
    end
  end

  def create
    @task = Task.new(params[:task])

    if @task.save!
      if request.xhr?
        goal = Goal.find(@task.goal_id)
        render partial: "task_unit", locals: {task: @task, goal: goal}
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
    @task = Task.find(params[:id])

    @task.destroy

    if request.xhr? 
      render nothing: true
    else
      redirect_to root_url
    end
  end

  def index

  end

  def show
    
  end

end