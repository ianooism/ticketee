class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  
  def index
    @projects = Project.all
  end
 
  def show
    @project = project
  end
  
  def new
    @project = Project.new
  end
  
  def edit
    @project = project
  end
  
  def create
    @project = Project.new(project_params)
    
    if @project.save
      flash[:notice] = 'Project created.'
      redirect_to project_url(@project)
    else
      render 'new'
    end
  end
  
  def update
    @project = project
    
    if @project.update(project_params)
      flash[:notice] = 'Project updated.'
      redirect_to project_url(@project)
    else
      render 'edit'
    end
  end
  
  def destroy
    project.destroy
    flash[:notice] = 'Project destroyed.'
    redirect_to projects_url
  end
  
  private
  
    def project
      Project.find(params[:id])
    end
    
    def project_params
      params.require(:project).permit(:project_name, :description)
    end
end
