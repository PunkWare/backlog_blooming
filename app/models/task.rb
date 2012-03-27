class Task < ActiveRecord::Base
  attr_accessible :code, :title, :remaining_effort
  belongs_to :user
  
  validates :code, presence: true
  validates :title, presence: true
  validates :remaining_effort, presence: true
  validates :user_id, presence: true
end
