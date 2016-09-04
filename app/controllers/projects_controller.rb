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
      redirect_to projects_url,
        notice: "Project successfully created."
    else
      render 'new'
    end
  end
  
  # GET /projects/:id/edit
  def edit
    @project = set_project
  end
  
  # PATCH or PUT /projects/:id
  def update
    @project = set_project
    if @project.update(project_params)
      redirect_to projects_url,
        notice: "Project successfully updated."
    else
      render 'edit'
    end
  end
  
  # DELETE /projects/:id
  def destroy
    @project = set_project
    @project.destroy
    redirect_to projects_url,
      notice: "Project successfully destroyed."
  end
  
  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
    
    def set_project
      Project.find(params[:id])
    end
end
