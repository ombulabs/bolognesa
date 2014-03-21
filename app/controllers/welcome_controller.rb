class WelcomeController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris.last(5)
  end

end
