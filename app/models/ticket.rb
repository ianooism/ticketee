class Ticket < ApplicationRecord
  belongs_to :author, class_name: 'User'
  
  validates :name, presence: true
  validates :description, presence: true
end
