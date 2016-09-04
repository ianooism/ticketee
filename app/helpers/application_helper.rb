module ApplicationHelper
  def show_error_message_for_form(object)
    if object.errors.any?
      "Oops, form contains #{pluralize(object.errors.count, 'error')}. " +
      "Please fix and try again."
    end
  end
  def show_error_messages_for_field(object, field)
    if object.errors.any?
      if object.errors.messages[field].any?
        object.errors.messages[field].to_sentence.upcase_first + "."
      end
    end
  end
end
