class Pomodori < ActiveRecord::Base

  belongs_to :user

  def set_finished
    self.update_attributes(:finished_at => Time.now)
  end

end
