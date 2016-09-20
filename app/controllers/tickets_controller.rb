class TicketsController < ApplicationController
  def show
    @ticket = ticket
    @comment = @ticket.comments.new
  end
  
  def new
    @ticket = project.tickets.new
  end
  
  def edit
    @ticket = ticket
  end
  
  def create
    @ticket = project.tickets.new(ticket_params)
    
    @ticket.author = current_user
    
    if @ticket.save
      redirect_to(project_ticket_url(@_project, @ticket),
        notice: 'Ticket created.')
    else
      render 'new'
    end
  end
  
  def update
    @ticket = ticket
    
    if @ticket.update(ticket_params)
      redirect_to(project_ticket_url(@_project, @ticket),
        notice: 'Ticket updated.')
    else
      render 'edit'
    end
  end
  
  def destroy
    ticket.destroy
    redirect_to project_url(@_project), notice: 'Ticket destroyed.'
  end
  
  private
  
    def project
      @_project = Project.find(params[:project_id])
    end
  
    def ticket
      project.tickets.find(params[:id])
    end
    
    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
