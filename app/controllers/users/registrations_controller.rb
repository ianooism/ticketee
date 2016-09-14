class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super
    if resource.persisted? && resource.active_for_authentication?
      set_flash_message! :notice, :signed_up_needs_confirmation,
        email: resource.email
    end
  end
end
