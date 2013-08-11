class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_time_zone
    old_time_zone = Time.zone
    if browser_timezone.present?
      Time.zone = browser_timezone 
      puts "TIME WAS RESET!!"
      puts Time.zone
    end
    puts "THIS CRAP WAS CALLED!!!"
    yield
  end

  def browser_timezone
    cookies["browser.timezone"]
  end

end
