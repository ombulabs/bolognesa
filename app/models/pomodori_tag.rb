class PomodoriTag < ActiveRecord::Base
  belongs_to :pomodori
  belongs_to :tag
end
