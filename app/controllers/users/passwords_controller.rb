class Users::PasswordsController < Devise::RegistrationsController
  before_action :authenticate_user!
  
  # GET /users/password/edit
  def edit
    @user = current_user
  end
  
  # POST /users/password
  def update
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      set_flash_message :notice, :updated_password
      bypass_sign_in @user
      redirect_to root_path
    else
      clean_up_passwords @user
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end
  
end
