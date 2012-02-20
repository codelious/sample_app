class SessionsController < ApplicationController
  
  def new
    @title = "Sign in"
  end
  
  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    
    if user.nil?
      # Sign the user in and redirect to the user's show page.
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
  end
  
end
