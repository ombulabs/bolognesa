class User < ActiveRecord::Base
  has_many :authorizations
  has_many :pomodoris

  def create_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create( :user => current_user, :provider => auth_hash["provider"], :uid => auth_hash["uid"] )
    end
  end

  def can_pomodori?
    if last_pomodori = self.pomodoris.last
      last_pomodori.created_at < Time.now - 5.minutes
    else
      return true
    end
  end

end
