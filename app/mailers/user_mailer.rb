class UserMailer < ActionMailer::Base
  default from: "angelo@lifetracker.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost.com/users/signin"
    mail(to: @user.email, subject: "Achievement Unlocked!")
  end

  def daily_update(user)
    @user = user
    @url = "http://localhost.com"
    mail(to: @user.email, subject: "Time to update LifeTracker")
  end

end
