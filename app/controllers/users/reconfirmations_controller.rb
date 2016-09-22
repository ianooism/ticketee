class Users::ReconfirmationsController < DeviseController
  def new
    @user = current_user
  end
  
  def create
    @user = current_user
    
    resource.send_reconfirmation_instructions
    set_flash_message :notice, :send_instructions
    redirect_to action: 'new'
  end
  
  private

    def translation_scope
      'devise.confirmations'
    end
end
