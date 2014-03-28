class Pomodori < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :tags

  def set_finished
    self.update_attributes(:finished_at => Time.now)
  end

  def self.today
    self.where(:created_at => Date.today)
  end

end
