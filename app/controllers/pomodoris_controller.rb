class PomodorisController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris.reverse

    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @pomodoris }
      # format.csv  { export_csv(current_user.pomodoris.order_by([[:created_at, :desc]])) }

    end
  end

  def edit
    @pomodori = Pomodori.find(params[:id])

    respond_to do |format|
      format.js # { render :json => { :html => render_to_string('edit')}, :content_type => 'text/json' }
    end
  end

  # Updates Pomodori's Tags
  def update
    @pomodoris = current_user.pomodoris.today.reverse
    @pomodori = Pomodori.find(params[:id])
    name = params[:pomodori][:tag][:name]
    @tag = Tag.find_or_create_by_name(name)
    unless @pomodori.tags.include?(@tag)
      @pomodori.tags << @tag
    end

    respond_to do |format|
      format.js
      #format.html { redirect_to root_path }
    end

    # @tag.update_attributes(:name => name)
  end

  def create
    Pomodori.new(user_id: current_user.id).save
  end

  def set_finished
    @pomodoris = current_user.pomodoris.today.reverse
    if @pomodori = current_user.pomodoris.last.set_finished
      respond_to do |format|
        format.js # { redirect_to root_path }
      end
    end
  end

  def set_tags
    @pomodori = current_user.pomodoris.last
  end


end
