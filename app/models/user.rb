class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable
  
  validates :full_name, presence: true
  
  def update_password_with_password(params)
    if not params[:password].blank? && params[:password_confirmation].blank?
      update_with_password(params)
    else
      self.errors.add(:password, :blank)
      false
    end
  end
  
  before_update :remove_unconfirmed_email, prepend: true,
    unless: proc { |user| user.email_changed? }
  
  protected
    
    def remove_unconfirmed_email
      self.unconfirmed_email = nil
    end
end
