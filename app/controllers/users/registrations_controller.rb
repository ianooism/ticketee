class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  
  # POST /resource
  def create
    super
    if resource.persisted? && resource.active_for_authentication?
      set_flash_message! :notice, :signed_up_needs_confirmation,
        email: resource.email
    end
  end
  
  protected
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
    end
end
