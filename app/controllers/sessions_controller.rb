class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    user = current_user
    sign_out
    if user
      flash[:message] = "Goodbye, #{user.name}.  You have been successfully signed out."
    end
    redirect_to root_url
  end
end
