Bolognesa::Application.routes.draw do

  root to: 'welcome#index'

  resources :users do
    resources :pomodoris
  end

  resources :pomodoris do
    collection { post :import }
  end

  get "/auth/:provider/callback" => "sessions#create"
  get '/auth/failure', :to => 'sessions#failure'
  get "/signout" => "sessions#destroy", :as => :signout
  get "/trello" => "sessions#trello"

  get "/pomodoris" => "pomodoris#index"
  get "/pomodoris/create" => "pomodoris#create"
  get "/pomodoris/set_finished" => "pomodoris#set_finished"
  get "/pomodoris/set_tags" => "pomodoris#set_tags"
  get "/today" => "pomodoris#today"
  get "/yesterday" => "pomodoris#yesterday"

  get "/settings" => "users#edit"
  get "/repeat_tags" => "pomodoris#repeat_tags"
  get "/delete_tag" => "pomodoris#delete_tag"
  get "/stats" => "users#stats"

  get "/get_trello_cards" => "pomodoris#get_trello_cards"
  get "/trello_settings" => "users#trello_settings"

end
