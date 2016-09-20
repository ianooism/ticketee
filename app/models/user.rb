class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable
  
  validates :full_name, presence: true
  
  before_save :remove_unconfirmed_email, on: :update,
    unless: Proc.new { |user| user.email_changed? }
  
  def update_password_with_password(params)
    if params[:password].blank? && params[:password_confirmation].blank?
      self.errors.add(:password, :blank)
      return false
    else
      update_with_password(params)
    end
  end
  
  protected
    
    def remove_unconfirmed_email
      self.unconfirmed_email = nil
    end
end
