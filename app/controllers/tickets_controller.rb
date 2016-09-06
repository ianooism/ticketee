class TicketsController < ApplicationController
  def show
    @project = set_project
    @ticket = @project.tickets.find(params[:id])
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
  
  private
    def set_project
      Project.find(params[:project_id])
    end
    
    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
