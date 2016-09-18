class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  
  def show
  end
  
  def new
    @ticket = @project.tickets.new
  end
  
  def edit
  end
  
  def create
    @ticket = @project.tickets.new(ticket_params)
    @ticket.author = current_user
    if @ticket.save
      redirect_to project_url(@project), notice: 'Ticket created.'
    else
      render 'new'
    end
  end
  
  def update
    if @ticket.update(ticket_params)
      redirect_to edit_project_ticket_url(@project, @ticket), notice: 'Ticket updated.'
    else
      render 'edit'
    end
  end
  
  def destroy
    @ticket.destroy
    redirect_to project_url(@project), notice: 'Ticket destroyed.'
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
