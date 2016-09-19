class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  
  scope :persisted, lambda {where.not(id: nil)}
  
  validates :body, presence: true
end
