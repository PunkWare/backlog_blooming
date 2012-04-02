class TasksController < ApplicationController
  before_filter :signed_in_user
  
  def edit
    @task = Task.find(params[:id]) 
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update_attributes(params[:task])
      
      flash[:success] = "Task updated"
      
      redirect_to user_tasks_path
    else
      render 'edit'
    end
  end
end
