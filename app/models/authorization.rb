class Authorization < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, presence: true

  def self.find_or_create_by_provider(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
      user = User.create(name: auth_hash['info']['name'], email: auth_hash['info']['email'], image: auth_hash['info']['image'], auth_hash: auth_hash.to_json)
      auth = create(user_id: user.id, provider: auth_hash['provider'], uid: auth_hash['uid'] )
    end
    auth
  end
end
