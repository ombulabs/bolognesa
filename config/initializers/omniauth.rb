ENV['GITHUB_KEY'] ||= 'f79c9b62edcf41af1649'
ENV['GITHUB_SECRET'] ||= 'bfd681dbaec5b31d8949bb115defc3c87daff119'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
