class Users::PasswordsController < DeviseController
  before_action :set_user
  
  def edit
  end
  
  def update
    if resource.update_with_password(user_params)
      bypass_sign_in resource
      flash_key = both_passwords_blank? ? :blank_password : :updated_password
      set_flash_message :notice, flash_key
      redirect_to edit_user_password_url
    else
      render 'edit'
    end
  end
  
  protected
  
    def set_user
      @user = current_user
    end
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end
    
    def both_passwords_blank?
      params[:user][:password].blank? &&
        params[:user][:password_confirmation].blank?
    end
    
    def translation_scope
      'devise.registrations'
    end
end
