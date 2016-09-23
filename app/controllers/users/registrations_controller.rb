class Users::RegistrationsController < Devise::RegistrationsController
  private
  
    def sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
      super
    end
end
