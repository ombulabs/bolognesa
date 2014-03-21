class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_uri
  helper_method :current_user, :authenticate_user!

  def check_uri
    url = redirect_to request.protocol + 'www.' + request.host_with_port +
          request.fullpath if Rails.env.to_s == 'production' &&
          !/^www/.match(request.host) && ENV['DEV'].nil?
  end

  def current_user
    @current_user ||= User.find_by_id(session[:id])
  end

  def authenticate_user!
    if session[:id]
      current_user
    else
      redirect_to '/'
    end
  end

end
