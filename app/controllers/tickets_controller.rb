class TicketsController < ApplicationController
  def show
    @project = set_project
    @ticket = set_ticket
  end
  
  def new
    @project = set_project
    @ticket = @project.tickets.new
  end
  def create
    @project = set_project
    @ticket = @project.tickets.create(ticket_params)
    if @ticket.save
      redirect_to project_path(@project),
        notice: 'Ticket successfully created.'
    else
      render 'new'
    end
  end
  
  def edit
    @project = set_project
    @ticket = set_ticket
  end
  def update
    @project = set_project
    @ticket = set_ticket
    if @ticket.update(ticket_params)
      redirect_to project_path(@project),
        notice: 'Ticket successfully updated.'
    else
      render 'edit'
    end
  end
  
  private
    def set_project
      Project.find(params[:project_id])
    end
    def set_ticket
      @project.tickets.find(params[:id])
    end
    
    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
