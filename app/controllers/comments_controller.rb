class CommentsController < ApplicationController
  
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @project = @ticket.project
    @comment = @ticket.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:notice] = 'Comment created.'
      redirect_to project_ticket_url(@project, @ticket)
    else
      render 'tickets/show'
    end
  end
  
  private
    
    def comment_params
      params.require(:comment).permit(:body)
    end
  
end
