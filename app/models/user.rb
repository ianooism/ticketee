class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable
  
  validates :full_name, presence: true
  
  # override devise. if current email entered, cancel pending confirmation.
  before_update :remove_unconfirmed_email, prepend: true,
                unless: proc { |user| user.email_changed? }
  
  # override devise. disallow blank passwords.
  def update_password(params)
    if not params[:password].blank? && params[:password_confirmation].blank?
      update_with_password(params)
    else
      self.errors.add(:password, :blank)
      false
    end
  end
  
  private
    
    def remove_unconfirmed_email
      self.unconfirmed_email = nil
    end
end
