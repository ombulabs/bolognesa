class PomodoriController < ApplicationController

  require 'pry'

  before_filter :authenticate_user!

  def index
    @pomodori = current_user.pomodori

    binding.pry

    respond_to do |format|
      format.html # index.html.erb
      # format.xml  { render :xml => @pomodori }
      # format.csv  { export_csv(current_user.pomodori.order_by([[:created_at, :desc]])) }
    end
  end

end
