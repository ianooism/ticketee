class Comment < ApplicationRecord
  belongs_to :author, class_name: :User
  
  belongs_to :ticket
  after_create :set_state_for_ticket
  after_create :add_author_as_ticket_subscriber
  after_create :send_notification_to_ticket_subscribers
  
  belongs_to :state
  
  belongs_to :previous_state, class_name: :State
  before_validation :set_previous_state, on: :create
  
  validates :body, presence: true
  
  scope :saved, -> { where.not(id: nil) }
  
  private
    def set_state_for_ticket
      ticket.update!(state: state) unless state == previous_state
    end
    
    def add_author_as_ticket_subscriber
      ticket.subscribers << author unless ticket.subscribers.include?(author)
    end
    
    def send_notification_to_ticket_subscribers
      (ticket.subscribers - [author]).each do |subscriber|
        CommentMailer.created(self, subscriber).deliver_now
      end
    end
    
    def set_previous_state
      self.previous_state = ticket.state
    end
end
