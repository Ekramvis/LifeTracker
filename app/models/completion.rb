class Completion < ActiveRecord::Base
  attr_accessible :task_id, :date_completed

  validates :task_id, :date_completed, presence: true 

  belongs_to :task
end