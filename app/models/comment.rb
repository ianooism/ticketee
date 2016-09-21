class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :author, class_name: :User
  belongs_to :state
  belongs_to :previous_state, class_name: :State
  
  validates :body, presence: true
  
  scope :persisted, lambda {where.not(id: nil)}
  
  before_validation :set_previous_state, on: :create
  after_create :set_ticket_state
  
  private
  
    def set_previous_state
      self.previous_state = ticket.state
    end
  
    def set_ticket_state
      ticket.state = state
      ticket.save!
    end
end
