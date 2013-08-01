class Task < ActiveRecord::Base
  attr_accessible :goal_id, :description, :frequency, :value

  validates :goal_id, :description, :frequency, :value, presence: true

  belongs_to :goal

  has_many :completions
end


