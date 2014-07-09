class PomodorisController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris.order('created_at DESC')
    respond_to do |format|
      format.js 
    end
  end

  def edit
    @pomodori = Pomodori.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # Updates Pomodori's Tags
  def update
    @pomodori = Pomodori.find(params[:id])

    name = params[:pomodori][:tag][:name]
    name.split(",").each do |tag|
      @tag = Tag.find_or_create_by_name(tag.strip)
      unless @pomodori.tags.include?(@tag)
        @pomodori.tags << @tag
      end
    end

    if card = params[:pomodori][:tag][:trello_cards]
      @pomodori.card_name = card
      @pomodori.save!
    end

    @pomodoris = current_user.pomodoris.today.reverse

    # Load correct Pomodoro list, if pomodoro was updated from today/yesterday/all partial. 
    unless @pomodoris.include? @pomodori
      @pomodoris = current_user.pomodoris.yesterday.reverse
    end
    unless @pomodoris.include? @pomodori
      @pomodoris = current_user.pomodoris.reverse
    end

    respond_to do |format|
      format.js
    end
  end

  def create
    Pomodori.new(user_id: current_user.id).save
    render :nothing => true
  end

  def set_finished
    @pomodoris = current_user.pomodoris.today.reverse
    @pomodori = current_user.pomodoris.last.set_finished
    render :nothing => true
  end

  def set_tags
    @pomodori = current_user.pomodoris.last
  end

  def today
    @pomodoris = current_user.pomodoris.today.reverse
    respond_to do |format|
      format.js
    end
  end

  def yesterday
    @pomodoris = current_user.pomodoris.yesterday.reverse
    respond_to do |format|
      format.js
    end
  end

  def import
    Pomodori.import(params[:file], current_user) # safe?
    redirect_to root_url, :notice => "Pomodoros imported from tomato.es"
  end

  def repeat_tags
    @pomodori = current_user.pomodoris.find(params[:pomodoro_id])
    @pomodoris = current_user.pomodoris.today.reverse
    @pomodori.repeat_tags
    respond_to do |format|
      format.js { render :action => "update" }
    end
  end

  def delete_tag
    @pomodoris = current_user.pomodoris.today.reverse
    @pomodori = current_user.pomodoris.find(params[:pomodori_id])
    tag = Tag.find(params[:tag_id])
    @pomodori.tags.delete(tag)
    respond_to do |format|
      format.js
    end
  end

end
