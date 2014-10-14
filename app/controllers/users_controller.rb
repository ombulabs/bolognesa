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

  def stats
    @user = current_user
    @tag_names = Tag.most_occurrences_for(current_user)
    @pomodori_counts = Pomodori.count_for_last_month(current_user)
    @tag_counts = Tag.count_for_last_month(current_user)
    respond_to do |format|
      format.js
    end
  end

end
