class Users::EmailsController < DeviseController
  before_action :set_user
  
  def edit
    resource.email = nil
  end
  
  def update
    if resource.update_with_password(user_params)
      # TODO: logic belongs in model
      #   if email entered = email in db, remove unconfirmed email
      #   note that devise has code that keeps email the same even when changed
      resource.update(unconfirmed_email: nil) if update_using_current_email?
      bypass_sign_in resource
      flash_key = resource.pending_reconfirmation? ?
        :update_email_needs_confirmation : :updated_email
      set_flash_message :notice, flash_key
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
      params.require(:user).permit(:email, :current_password)
    end

    def update_using_current_email?
      params[:user][:email] == resource.email
    end

    def translation_scope
      'devise.registrations'
    end
end
