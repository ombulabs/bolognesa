class SessionsController < ApplicationController

  def create
    if session[:id]
      current_user.create_provider(auth_hash)
    else
      auth = Authorization.find_or_create_by_provider(auth_hash)
      session[:id] = auth.user_id
    end
      redirect_to '/', :notice => "Signed in!"
  end

  def destroy
    session[:id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def failure
    redirect_to '/', :alert => 'Sorry, something went wrong. Try again.'
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end

end
