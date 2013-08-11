class ApplicationController < ActionController::Base
  protect_from_forgery


  private 

  def set_time_zone
    old_time_zone = Time.zone
    Time.zone = browser_timezone if browser_timezone.present?
    yield
  end

  def browser_timezone
    cookies["browser.timezone"]
  end
  
end
