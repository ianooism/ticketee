class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: :User
  belongs_to :state
  belongs_to :previous_state, class_name: :State
  
  validates :body, presence: true
  
  scope :saved, -> { where.not(id: nil) }
  
  before_validation :set_previous_state, on: :create
  after_create :set_state_for_ticket
  
  private
  
    def set_previous_state
      self.previous_state = ticket.state
    end
  
    def set_state_for_ticket
      ticket.state = state
      ticket.save!
    end
end
