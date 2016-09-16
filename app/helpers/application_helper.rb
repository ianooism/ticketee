module ApplicationHelper
  def get_error_message(object)
    if object.errors.any?
      "Please fix the form errors before trying again."
    end
  end
  def get_error_message_for(object, field)
    # if we use full message then we cannot customize input label
    # message = object.errors.full_messages_for(field).first
    message = object.errors.messages[field].first
    "Error: #{message}." if message
  end
end
