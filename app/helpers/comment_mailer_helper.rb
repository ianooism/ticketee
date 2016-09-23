module CommentMailerHelper
  def ticket
    @comment.ticket
  end
  
  def project
    @comment.ticket.project
  end
end
