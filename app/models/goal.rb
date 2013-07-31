class Goal < ActiveRecord::Base
  attr_accessible :objective, :user_id

  validates :objective, :user_id, presence: true

  belongs_to :user

  has_many :tasks, dependent: :destroy
end