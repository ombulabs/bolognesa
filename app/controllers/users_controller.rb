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
    if params[:user][:time_zone]
      @user.time_zone = params[:user][:time_zone]
    elsif board = params[:user][:current_board] 
      @user.current_board = board # Update current board. 
      id = eval(current_user.boards)["#{board}"] # Get ID for chosen board. 
      @user.cards = @trello.find(:boards, id).cards.map(&:name).to_s # Load cards from Trello.
    end
    @user.save!
    respond_to do |format|
      format.js 
    end
  end

  def stats
    @user = current_user
    @tag_names = Tag.most_occurrences_for(current_user)
    respond_to do |format|
      format.js
    end
  end

end
