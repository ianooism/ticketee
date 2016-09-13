class Users::EmailsController < DeviseController
  before_action :authenticate_user!
  
  # GET /account/email/edit
  def edit
    @user = current_user
  end
  
  # POST /account/email
  def update
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      bypass_sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :current_password)
    end
  
end
