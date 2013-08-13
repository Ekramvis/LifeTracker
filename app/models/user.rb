class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  attr_accessible :username, :email, :password, :password_confirmation, 
                  :remember_me, :login, :subscribed, :unsubscribe_token,
                  :time_zone

  attr_accessor :login

  validates :username, :uniqueness => { :case_sensitive => false }

  has_many :goals, dependent: :destroy
  has_many :tasks, through: :goals

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def confirm!
    welcome_message
    super 
  end

  def welcome_message
    UserMailer.welcome_email(self).deliver
  end

  
  def total_possible_points_per_week
    total_points = 0

    self.tasks.each do |task|
      days_tracked = ((Time.now.in_time_zone - task.created_at) / (60 * 60 * 24)).to_i
      if days_tracked > 6
        total_points += (task.value * task.frequency) 
      else
        limit = task.completions.select { |completion| completion.date_completed > (Time.now.in_time_zone.to_date - 7.days)}.take(task.frequency).size
        total_points += (task.value * [task.frequency, limit].max) 

        # last_completion_date = task.completions.max { |c| c.date_completed }.try(:date_completed)
        # if last_completion_date 
        #   days_from_first_completion = (Time.now.in_time_zone.to_date - last_completion_date).to_i
        # else
        #   days_from_first_completion = 1
        # end
        # limit = task.completions.select { |completion| completion.date_completed > (Time.now.in_time_zone.to_date - 7.days)}.take(task.frequency).size

        # puts "limit is #{limit}"
        # puts "days_from_first_completion is #{days_from_first_completion}"
        # puts "last_completion_date is #{last_completion_date}"

        # total_points += (task.value * [(task.frequency / (7.0 / days_from_first_completion) ).ceil, limit].max) 

        # puts "total_points is #{total_points}"
      end
    end

    total_points
  end


  def points_earned_last_7_days
    points_earned = 0

    self.tasks.each do |task|
      last_completions = []
      last_completions += task.completions.select { |completion| completion.date_completed > (Time.now.in_time_zone.to_date - 7.days)}.take(task.frequency)          
      points_earned += task.value * last_completions.size
    end

    points_earned
  end


  def trailing_7_day_average

    if self.total_possible_points_per_week > 0
      ((self.points_earned_last_7_days * 100.00) / self.total_possible_points_per_week).round(2).to_s + "%"
    else
      "0.00%"
    end
  end

end
