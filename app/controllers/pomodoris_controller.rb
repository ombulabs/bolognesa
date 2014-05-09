class PomodorisController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris.order('created_at DESC')
    respond_to do |format|
      format.js # index.html.erb
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
    name.split(",").each do |tag|
      @tag = Tag.find_or_create_by_name(tag.strip)
      unless @pomodori.tags.include?(@tag)
        @pomodori.tags << @tag
      end
    end

    respond_to do |format|
      format.js
    end
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
    @tag = @pomodori.tags.find(params[:tag_id])
    @tag.destroy
    respond_to do |format|
      format.js
    end
  end
end
