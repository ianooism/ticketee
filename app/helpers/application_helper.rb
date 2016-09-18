module ApplicationHelper
  def get_errors_if_dev_env(object)
    if Rails.env.development? && object.errors.any?
      "Error: #{object.errors.messages}"
    end
  end
  def get_error_message_for_form(object)
    if object.errors.any?
      I18n.t 'errors.messages.form_unsubmitted'
    end
  end
  def get_error_message_for(object, field)
    object.errors.messages[field].first
  end
end
