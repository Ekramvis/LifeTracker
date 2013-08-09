class UsersController < ApplicationController 

  def unsubscribe
    @user = User.find_by_unsubscribe_token(params[:unsubscribe_token])

    if @user
      @user.subscribed = false
      @user.save!
    end

  end


end