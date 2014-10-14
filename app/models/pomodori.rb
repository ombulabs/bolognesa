class Pomodori < ActiveRecord::Base

  require 'csv'

  belongs_to :user
  has_many :tags, :through => :pomodori_tags
  has_many :pomodori_tags

  def set_finished
    self.update_attributes(:finished_at => Time.now)
  end

  def repeat_tags
    if self.tags.empty?
      self.tags = second_to_last.tags
    else
      self.tags = self.user.pomodoris.last.tags
    end
  end

  def second_to_last
    self.user.pomodoris.order("created_at DESC").offset(1).limit(1).first
  end

  def self.today
    self.where(["created_at >= ? AND created_at <= ?", Date.today.beginning_of_day, Date.today.end_of_day])
  end

  def self.yesterday
    self.where(["created_at >= ? AND created_at <= ?", Date.yesterday.beginning_of_day, Date.yesterday.end_of_day])
  end

  def self.import(file, user)
    tags = []
    CSV.foreach(file.path, :headers => true) do |row|
      pomodori = Pomodori.create!(created_at: row[0].to_datetime - 25.minutes, finished_at: row[0].to_datetime)
      row[1].split(", ").each do |tag|
        tag = Tag.find_or_create_by_name(name: tag)
        pomodori.tags << tag
      end
      user.pomodoris << pomodori
      user.save
    end
  end

  def self.count_for_last_month(user)
    where(user_id: user.id).
    group('date(created_at)').count.map do |k, v|
      [k.to_time.to_i*1000, v]
    end
  end

end
