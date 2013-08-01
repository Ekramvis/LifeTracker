class CompletionsController < ApplicationController 

  def new
    @completion = Completion.new

    @task = Task.find(params[:task_id]) if params[:task_id]
  end

  def create
    @completion = Completion.new(params[:completion])

    if @completion.save
      if request.xhr? 
        render nothing: true 
      else
        redirect_to root_url
      end
    else
      render :new
    end
  end

end 