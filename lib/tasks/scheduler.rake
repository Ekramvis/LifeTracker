

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
        if user.unsubscribe_token.nil?
          user.unsubscribe_token = SecureRandom.urlsafe_base64(8) 
          user.save!
        end
        UserMailer.daily_update(user).deliver
      end
    end
  end

  task :all => [:update_stats, :send_email]
end