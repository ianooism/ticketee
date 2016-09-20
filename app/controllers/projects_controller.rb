class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  
  def index
    @projects = Project.all
  end
 
  def show
  end
  
  def new
    @project = Project.new
  end
  
  def edit
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
    if @project.update(project_params)
      flash[:notice] = 'Project updated.'
      redirect_to project_url(@project)
    else
      render 'edit'
    end
  end
  
  def destroy
    @project.destroy
    flash[:notice] = 'Project destroyed.'
    redirect_to projects_url
  end
  
  private
  
    def set_project
      @project = Project.find(params[:id])
    end
    
    def project_params
      params.require(:project).permit(:project_name, :description)
    end
end
