class UsersController < ApplicationController

  def edit
    @user = current_user
    respond_to do |format|
      format.js
    end
  end

  def update
    @user = current_user
    @pomodoris = current_user.pomodoris.today.reverse
    @user.time_zone = params[:user][:time_zone]
    @user.save!
    respond_to do |format|
      format.js
    end
  end

end
