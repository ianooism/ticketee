class Users::PasswordsController < DeviseController
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    if resource.update_password(user_params)
      bypass_sign_in resource
      set_flash_message :notice, :updated_password
      redirect_to action: 'edit'
    else
      render 'edit'
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation,
                                   :current_password)
    end
    
    def translation_scope
      'devise.registrations'
    end
end
