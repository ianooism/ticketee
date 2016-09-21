class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: :User
  belongs_to :state
  
  scope :persisted, lambda {where.not(id: nil)}
  
  validates :body, presence: true
end
