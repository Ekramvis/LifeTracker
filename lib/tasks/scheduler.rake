

desc "Task group called by Heroku scheduler"

namespace :checkin do 

  desc "updates most recent stats for each user"
  task :update_stats => :environment do 

    puts "updating your stats"

  end

  desc "sends out a daily email update to each user"
  task :send_email => :environment do 
    User.all.each do |user|
      if user.subscribed == true
        UserMailer.daily_update(user).deliver
      end
    end
  end

  task :all => [:update_stats, :send_email]
end