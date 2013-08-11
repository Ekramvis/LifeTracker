class UsersController < ApplicationController 

  def unsubscribe
    @user = User.find_by_unsubscribe_token(params[:unsubscribe_token])

    if @user
      @user.subscribed = false
      @user.save!
    end

  end

  def average_score
    if request.xhr?
      render partial: "average_score"
    else
      redirect_to root_url
    end
  end


end