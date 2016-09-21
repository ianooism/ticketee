class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: :User
  belongs_to :state
  
  validates :body, presence: true
  
  scope :persisted, lambda {where.not(id: nil)}
end
