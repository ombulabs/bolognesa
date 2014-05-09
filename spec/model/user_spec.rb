require 'spec_helper'

describe User do
  it 'should create from omniauth' do
    auth = OmniAuth.config.mock_auth[:github]
    @auth = Authorization.find_or_create_by_provider(auth)
    @user = @auth.user
    @user.should == User.last
  end
end
