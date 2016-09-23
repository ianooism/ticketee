class Comment < ApplicationRecord
  belongs_to :ticket
  after_create :set_ticket_state
  after_create :notify_ticket_subscribers
  
  belongs_to :author, class_name: :User
  
  belongs_to :state
  
  belongs_to :previous_state, class_name: :State
  before_validation :set_previous_state, on: :create
  
  validates :body, presence: true
  
  scope :saved, -> { where.not(id: nil) }
  
  private
    def set_ticket_state
      ticket.update!(state: state) unless state == previous_state
    end
    
    def notify_ticket_subscribers
      (ticket.subscribers - [author]).each do |subscriber|
        CommentMailer.created(self, subscriber).deliver_now
      end
    end
    
    def set_previous_state
      self.previous_state = ticket.state
    end
end
