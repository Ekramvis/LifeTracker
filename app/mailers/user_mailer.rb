class UserMailer < ActionMailer::Base
  default from: "angelo@superawesome.me"

  def welcome_email(user)
    @user = user
    @url = "http://www.superawesome.me"
    mail(to: @user.email, subject: "Level Up!")
  end

  def daily_update(user)
    @user = user
    @url = "http://www.superawesome.me"
    mail(to: @user.email, subject: "You are #{@user.trailing_7_day_average} awesome!")
  end

end
