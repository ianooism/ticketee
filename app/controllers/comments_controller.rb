class CommentsController < ApplicationController
  
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @comment = @ticket.comments.new(comment_params)
    
    @comment.author = current_user
    
    if @comment.save
      redirect_to(project_ticket_url(@ticket.project, @ticket),
        notice: 'Comment created.')
    else
      render 'tickets/show'
    end
  end
  
  private
    
    def comment_params
      params.require(:comment).permit(:body)
    end
end
