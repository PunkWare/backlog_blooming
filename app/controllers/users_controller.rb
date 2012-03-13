class UsersController < ApplicationController
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #success
    else
      render 'new'
    end
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
end
