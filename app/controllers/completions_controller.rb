class CompletionsController < ApplicationController 
  around_filter :set_time_zone

  def new
    @completion = Completion.new

    @task = Task.find(params[:task_id]) if params[:task_id]
  end

  def create
    @completion = Completion.new(params[:completion])

    if @completion.save
      if request.xhr? 
        task_id = params[:completion][:task_id].to_i
        date_completed = params[:completion][:date_completed]
        render partial: "completion_confirm", locals: {task_id: task_id, date_completed: date_completed}
      else
        redirect_to root_url
      end
    else
      render :new
    end
  end

  def completed
    task_id = params[:completion][:task_id].to_i
    date_completed = params[:completion][:date_completed]
    
    render partial: "completion_confirm", locals: {task_id: task_id, date_completed: date_completed}
  end


end 