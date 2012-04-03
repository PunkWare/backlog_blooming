class Task < ActiveRecord::Base
  attr_accessible :code, :title, :remaining_effort
  belongs_to :user
  
  validates :code, presence: true
  validates :title, presence: true
  validates :remaining_effort, presence: true
  validates_numericality_of :remaining_effort, :only_integer => true
  validates :user_id, presence: true
  
  default_scope order: 'tasks.code'
end
