class Users::EmailsController < Devise::RegistrationsController
  # POST /users/email
  def update
    prev_unconfirmed_email = resource.unconfirmed_email
    super
    if resource.persisted? && is_flashing_format?
      flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
        :update_email_needs_confirmation : :updated_email
      set_flash_message :notice, flash_key
    end
  end
end
