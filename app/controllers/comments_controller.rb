class CommentsController < ApplicationController
  before_action :set_ticket, only: :create
  before_action :set_project, only: :create
  
  def create
    @comment = @ticket.comments.new(comment_params)
    @comment.author = current_user
    if @comment.save
      redirect_to project_ticket_url(@project, @ticket), notice: 'Comment created.'
    else
      render 'tickets/show'
    end
  end
  
  private
    
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end
    
    def set_project
      @project = @ticket.project
    end
    
    def comment_params
      params.require(:comment).permit(:body)
    end
  
end
