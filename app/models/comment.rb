class Comment < ApplicationRecord
  belongs_to :ticket
  after_create :set_state_for_ticket
  
  belongs_to :author, class_name: :User
  
  belongs_to :state
  
  belongs_to :previous_state, class_name: :State
  before_validation :set_previous_state, on: :create
  
  validates :body, presence: true
  
  scope :saved, -> { where.not(id: nil) }
  
  private
    def set_state_for_ticket
      ticket.update!(state: state)
    end
    
    def set_previous_state
      self.previous_state = ticket.state
    end
end
