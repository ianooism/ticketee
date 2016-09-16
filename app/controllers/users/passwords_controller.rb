class Users::PasswordsController < DeviseController
  before_action :set_user
  
  def edit
  end
  
  def update
    # override devise
    if both_passwords_blank?
      resource.errors.add :password, :blank
      render 'edit' and return
    end
    if resource.update_with_password(user_params)
      bypass_sign_in resource
      set_flash_message :notice, :updated_password
      redirect_to action: 'edit'
    else
      render 'edit'
    end
  end
  
  protected
  
    def set_user
      # devise requirement. resource() requires @user to be set
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
