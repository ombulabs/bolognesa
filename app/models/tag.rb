class Tag < ActiveRecord::Base
  has_many :pomodoris, :through => :pomodori_tags
  has_many :pomodori_tags

  def find_or_create_by_name(name)
    unless @tag = Tag.find_by_name(name)
      @tag = Tag.create(:name => name)
    end
  end

end
