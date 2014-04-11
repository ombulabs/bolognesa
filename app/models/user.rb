class User < ActiveRecord::Base
  has_many :authorizations
  has_many :pomodoris

  attr_accessible :time_zone, :name, :email, :image, :auth_hash

  def create_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create(:user_id => current_user.id, :provider => auth_hash["provider"], :uid => auth_hash["uid"] )
    end
  end

  def auth_json
    JSON.parse(self.auth_hash)
  end

end
