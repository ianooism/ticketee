class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: :User
  belongs_to :state
  
  has_many :comments, dependent: :delete_all
  
  validates :name, presence: true
  validates :description, presence: true
  
  before_validation :set_default_state, on: :create
  
  private
  
    def set_default_state
      self.state ||= State.default
    end
end
