require 'trello'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :connect_trello
  before_filter :set_user_time_zone
  helper_method :current_user, :authenticate_user!

  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }

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

  def connect_trello
    if current_user
      if current_user.trello_token
        @trello = Trello::Client.new(
          :developer_public_key => "27f4d6ec9fbc1e17be4f1464978e0199",
          :member_token => current_user.trello_token
        ) unless @trello
        unless current_user.boards
          current_user.boards = {}
          @trello.find(:member, "me").boards.each do |board|
            current_user.boards["#{board.name}"] = board.id
          end
          current_user.save!
        end
      end
    end
  end

end
