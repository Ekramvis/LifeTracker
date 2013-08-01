

desc "Task called by Heroku scheduler"


task :update_stats => :environment do 
  puts "updating your stats for real"
end

  
task :send_email => :environment do 
  User.all.each do |user|
    UserMailer.daily_update(user).deliver
  end
end

