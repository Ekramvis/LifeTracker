class UserMailer < ActionMailer::Base
  default from: "angelo@superawesome.me"

  def welcome_email(user)
    @user = user
    @url = "http://superawesome.me"
    mail(to: @user.email, subject: "Level Up!")
  end

  def daily_update(user)
    @user = user
    @url = "http://superawesome.me"
    mail(to: @user.email, subject: "SuperAwesomeYou Time!")
  end

end
