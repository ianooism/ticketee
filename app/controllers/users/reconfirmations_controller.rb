class Users::ReconfirmationsController < DeviseController
  before_action :set_user
  
  def new
  end
  
  def create
    resource.send_reconfirmation_instructions
    set_flash_message :notice, :send_instructions
    redirect_to action: 'new'
  end
  
  protected
  
    def set_user
      # devise requirement. resource() requires @user to be set
      @user = current_user
    end

    def translation_scope
      'devise.confirmations'
    end
end
