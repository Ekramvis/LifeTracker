class Task < ActiveRecord::Base
  attr_accessible :goal_id, :description, :frequency, :value, :cap

  validates :goal_id, :description, :frequency, :value, :cap, presence: true

  belongs_to :goal
end


