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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      
      flash[:success] = "Profile updated"
      
      # the user is signed again as part of a successful profile update;
      # this is because the remember token gets reset when the user is saved
      # which invalidates the user’s session.
      # This is a nice security feature, as it means that any hijacked sessions
      # will automatically expire when the user information is changed
      sign_in @user
      
      redirect_to @user
    else
      render 'edit'
    end
  end
end
