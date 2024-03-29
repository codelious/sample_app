class UsersController < ApplicationController
  
  def show 
    @user = User.find(params[:id]) 
    @title = @user.name
  end
  
  def new
    #@title = "Sign up now!"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Bienvenido a la aplicacion"
      redirect_to @user
    else
      render 'new'
    end
  end
end
