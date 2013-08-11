module ApplicationHelper

  def localdate
    Time.now.in_time_zone.to_date
  end

  def date_formatted(sub = 0)
    (localdate - sub.days).strftime("%a %b ") + (localdate - sub.days).strftime("%d").to_i.ordinalize
  end
end