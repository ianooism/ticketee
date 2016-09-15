class Users::EmailsController < DeviseController
  before_action :set_user
  
  # GET /users/email/edit
  def edit
  end
  
  # PUT /users/email
  def update
    previous_unconfirmed_email = resource.unconfirmed_email
    resource.update(unconfirmed_email: nil)
    if resource.update_with_password(user_params)
      bypass_sign_in resource
      flash_key = update_needs_confirmation?(previous_unconfirmed_email) ?
        :update_email_needs_confirmation : :updated_email
      set_flash_message :notice, flash_key
      redirect_to edit_user_email_url
    else
      render 'edit'
    end
  end
  
  protected
  
    def set_user
      @user = current_user
    end
  
    def user_params
      params.require(:user).permit(:email, :current_password)
    end
  
    def update_needs_confirmation?(previous_unconfirmed_email)
      resource.pending_reconfirmation? &&
        previous_unconfirmed_email != resource.unconfirmed_email
    end
    
    def translation_scope
      'devise.registrations'
    end
end
