class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, except: [:new, :create]
  
  def show
  end
  
  def new
    @ticket = @project.tickets.new
  end
  def create
    @ticket = @project.tickets.create(ticket_params)
    if @ticket.save
      redirect_to project_path(@project),
        notice: 'Ticket successfully created.'
    else
      render 'new'
    end
  end
  
  def edit
  end
  def update
    if @ticket.update(ticket_params)
      redirect_to project_path(@project),
        notice: 'Ticket successfully updated.'
    else
      render 'edit'
    end
  end
  
  def destroy
    @ticket.destroy
    redirect_to project_path(@project),
      notice: 'Ticket successfully destroyed.'
  end
  
  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end
    
    def ticket_params
      params.require(:ticket).permit(:name, :description)
    end
end
