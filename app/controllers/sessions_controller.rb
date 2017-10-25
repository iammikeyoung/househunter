class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:notice] = 'You have successfully logged in'
      redirect_to user
    elsif !user
      flash.now[:notice] = 'That email is not registered'
      render 'new'
    else
      flash.now[:notice] = 'Invalid email/password combination'
      render 'new'
    end

  end

  def destroy
  end

end
