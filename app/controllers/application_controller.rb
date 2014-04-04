class ApplicationController < ActionController::Base
  protect_from_forgery

  #before_filter :check_uri
  before_filter :set_user_time_zone
  helper_method :current_user, :authenticate_user!

  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }

  #def check_uri
  #  url = redirect_to request.protocol + 'www.' + request.host_with_port +
  #        request.fullpath if Rails.env.to_s == 'production' &&
  #        !/^www/.match(request.host) && ENV['DEV'].nil?
  #end

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

  def set_user_time_zone
    Time.zone = current_user.time_zone if current_user
  end

end
