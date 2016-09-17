module ApplicationHelper
  def get_error_message(object)
    if object.errors.any?
      I18n.t 'errors.messages.form_unsubmitted'
    end
  end
  def get_error_message_for(object, field)
    object.errors.messages[field].first
  end
end
