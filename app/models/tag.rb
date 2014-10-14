class Tag < ActiveRecord::Base
  has_many :pomodoris, through: :pomodori_tags
  has_many :pomodori_tags

  def find_or_create_by_name(name)
    unless @tag = Tag.find_by_name(name)
      @tag = Tag.create(name: name)
    end
  end

  def self.most_occurrences_for(user)
    counts = Hash.new(0)
    tag_names = tag_names_for(user)
    tag_names.each do |name|
      counts[name] += 1
    end
    counts.to_a
  end

  def self.tag_names_for(user)
    tag_names = joins(:pomodoris).
    where(pomodoris: { user_id: user.id }).
    map(&:name)
  end

  def self.count_for_last_month(user)
    joins(:pomodoris).
    where(pomodoris: { user_id: user.id }).
    group('date(pomodori_tags.created_at)').count.map do |k, v|
      [k.to_time.to_i*1000, v]
    end
  end

end
