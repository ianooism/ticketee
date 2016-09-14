class Users::PasswordsController < Devise::RegistrationsController
  # POST /users/password
  def update
    super
    if resource.persisted? && is_flashing_format?
      set_flash_message :notice, :updated_password
    end
  end
end
