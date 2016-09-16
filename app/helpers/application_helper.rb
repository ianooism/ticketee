module ApplicationHelper
  def get_error_message(object)
    if object.errors.any?
      "Please fix the form errors before trying again."
    end
  end
  def get_error_message_for(object, field)
    message = object.errors.full_messages_for(field).first
    "Error: #{message}." if message
  end
end
