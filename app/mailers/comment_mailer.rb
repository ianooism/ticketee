class CommentMailer < ApplicationMailer
  def created(comment, user)
    @comment = comment
    @ticket = @comment.ticket
    @project = @ticket.project
    @author = comment.author
    @user = user
    
    subject = "New comment for #{@project.name}/#{@ticket.name}"
    mail to: @user.email, subject: subject
  end
end
