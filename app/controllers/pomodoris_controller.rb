class PomodorisController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris

    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @pomodoris }
      # format.csv  { export_csv(current_user.pomodoris.order_by([[:created_at, :desc]])) }

    end
  end

  def edit

  end

  def create
    # If pomodori was not created within last 5 minutes, create new Pomodori
    if current_user.can_pomodori?
      if @pomodori = Pomodori.new(user_id: @current_user.id).save
        redirect_to :root
      end
    end
  end

  def set_finished
    if @pomodori = current_user.pomodoris.last.set_finished
      redirect_to :root
    end
  end


end
