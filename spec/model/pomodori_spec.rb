require 'spec_helper'

describe "Pomodori" do
  before do
    OmniAuth.config.mock_auth[:github]
  end

  it "displays pomodori" do
    visit root_path
    click_link "Sign in with Github"
    User.last.pomodoris << Pomodori.create!
    User.last.pomodoris.last.update_attributes(finished_at: Time.now)
    visit root_path
    page.should have_content("Pomodoro #1")
  end

  it "creates pomodori for a user" do
    visit root_path
    click_link "Sign in with Github"
    click_button "Start"
    Pomodori.last.should == User.last.pomodoris.last
  end

  it "creates tags for pomodori" do
    Pomodori.create!
    @tag = Pomodori.last.tags.create!(name: "Test Tag")
    Pomodori.last.tags.first.should == @tag
  end
end
