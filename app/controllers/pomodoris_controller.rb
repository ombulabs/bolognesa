class PomodorisController < ApplicationController

  def index
    @pomodoris = current_user.pomodoris

    respond_to do |format|
      format.html # index.html.erb
      #  format.xml  { render :xml => @pomodoris }
      #  format.csv  { export_csv(current_user.pomodoris.order_by([[:created_at, :desc]])) }
    end

  end

end
