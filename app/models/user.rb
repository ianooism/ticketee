class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable
  
  before_update :remove_unconfirmed_email,
    unless: Proc.new { |user| user.email_changed? }, prepend: true
  
  validates :full_name, presence: true
  
  protected
    
    def remove_unconfirmed_email
      self.unconfirmed_email = nil
    end
end
