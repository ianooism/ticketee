class ProjectsController < ApplicationController
  # GET /projects
  def index
    @projects = Project.all
  end
  
  # GET /projects/:id
  def show
    @project = set_project
  end
  
  # GET /projects/new
  def new
    @project = Project.new
  end
  
  # POST /projects
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_url(@project),
        notice: "#{Project.model_name.human} successfully created."
    else
      render 'new'
    end
  end
  
  # GET /projects/:id/edit
  def edit
    @project = set_project
  end
  
  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
    
    def set_project
      Project.find(params[:id])
    end
end
