class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable
  
  validates :full_name, presence: true
  
  before_save :remove_unconfirmed_email, on: :update,
    unless: proc { |user| user.email_changed? }
  
  def update_password_with_password(params)
    if not params[:password].blank? && params[:password_confirmation].blank?
      update_with_password(params)
    else
      self.errors.add(:password, :blank)
      false
    end
  end
  
  protected
    
    def remove_unconfirmed_email
      self.unconfirmed_email = nil
    end
end
