class Pomodori < ActiveRecord::Base

  belongs_to :user
  has_many :tags, :through => :pomodori_tags
  has_many :pomodori_tags

  def set_finished
    self.update_attributes(:finished_at => Time.now)
  end

  def self.today
    self.where(:created_at => Date.today)
  end

end
