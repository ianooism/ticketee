class Users::EmailsController < Devise::RegistrationsController
  before_action :authenticate_user!
  
  # GET /users/email/edit
  def edit
    @user = current_user
  end
  
  # POST /users/email
  def update
    @user = User.find(current_user.id)
    prev_unconfirmed_email = @user.unconfirmed_email
    if @user.update_with_password(user_params)
      flash_key = update_needs_confirmation?(@user, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
      set_flash_message :notice, flash_key
      bypass_sign_in @user
      redirect_to root_path
    else
      clean_up_passwords @user
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :current_password)
    end
  
end
