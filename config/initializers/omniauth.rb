ENV['GITHUBTEST_KEY'] ||= 'f79c9b62edcf41af1649'
ENV['GITHUBTEST_SECRET'] ||= 'bfd681dbaec5b31d8949bb115defc3c87daff119'

ENV['GITHUB_KEY'] ||= 'ef81ae0a09f864a5b48c'
ENV['GITHUB_SECRET'] ||= '4638e142a9f4f9f1932b1e60e2d6088cbf5d03cf'

if Rails.env.production?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  end
else
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUBTEST_KEY'], ENV['GITHUBTEST_SECRET']
  end
end
