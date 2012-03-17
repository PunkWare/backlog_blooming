class UsersController < ApplicationController
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[ :success ] = "Welcome and let's bloom !"
      
      #redirect_to user_path(@user)
      
      # Immediately sign in the new user
      user = User.find_by_email(@user.email) 
      if user && user.authenticate(@user.password)
        sign_in user
      end
        
      redirect_to user_path(@user)
        
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
