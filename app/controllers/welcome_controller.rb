class WelcomeController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris.last(5) if current_user
  end

end
