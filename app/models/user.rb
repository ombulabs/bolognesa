class User < ActiveRecord::Base
  has_many :authorizations

  def create_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"],
            auth_hash["uid"])
      Authorization.create( :user => current_user,
            :provider => auth_hash["provider"],
            :uid => auth_hash["uid"] )
    end
  end
end
