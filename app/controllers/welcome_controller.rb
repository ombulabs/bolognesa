class WelcomeController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris.today.reverse if current_user
  end

end
