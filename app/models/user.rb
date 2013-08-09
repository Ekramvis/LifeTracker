class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  attr_accessible :username, :email, :password, :password_confirmation, 
                  :remember_me, :login, :subscribed, :unsubscribe_token

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
      total_points += (task.value * task.frequency)
    end

    total_points
  end

  def points_earned_last_7_days
    points_earned = 0

    self.tasks.each do |task|
      last_completions = []
      # last_completions += task.completions.find_by_sql("SELECT * FROM tasks WHERE ", Date.today, Date.today - 6.days)
      last_completions += task.completions.where("date_completed = ?", Date.today)
      last_completions += task.completions.where("date_completed = ?", Date.today - 1.days)
      last_completions += task.completions.where("date_completed = ?", Date.today - 2.days)
      last_completions += task.completions.where("date_completed = ?", Date.today - 3.days)
      last_completions += task.completions.where("date_completed = ?", Date.today - 4.days)
      last_completions += task.completions.where("date_completed = ?", Date.today - 5.days)
      last_completions += task.completions.where("date_completed = ?", Date.today - 6.days)
      p last_completions
      p task.value
      points_earned += task.value * last_completions.size
    end

    points_earned
  end


  def trailing_7_day_average
    if self.total_possible_points_per_week > 0
      ((self.points_earned_last_7_days * 100.00) / self.total_possible_points_per_week).round(2).to_s + " %"
    else
      "0.00 %"
    end
  end



end
