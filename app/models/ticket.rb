class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: :User
  has_many :comments
  
  validates :name, presence: true
  validates :description, presence: true
end
