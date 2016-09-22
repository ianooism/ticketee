class Users::EmailsController < DeviseController
  def edit
    @user = current_user
    
    resource.email = nil
  end
  
  def update
    @user = current_user
    
    if resource.update_with_password(user_params)
      bypass_sign_in resource
      flash_key = resource.pending_reconfirmation? ?
                  :update_email_needs_confirmation : :updated_email
      set_flash_message :notice, flash_key
      redirect_to action: 'edit'
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:email, :current_password)
    end

    def translation_scope
      'devise.registrations'
    end
end
