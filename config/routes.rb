Bolognesa::Application.routes.draw do

  root to: 'welcome#index'

  resources :users do
    resources :pomodoris
  end

  resources :pomodoris do
    collection { post :import }
  end

  match "/auth/:provider/callback" => "sessions#create"
  match '/auth/failure', :to => 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout
  match "/trello" => "sessions#trello"

  match "/pomodoris" => "pomodoris#index"
  match "/pomodoris/create" => "pomodoris#create"
  match "/pomodoris/set_finished" => "pomodoris#set_finished"
  match "/pomodoris/set_tags" => "pomodoris#set_tags"
  match "/today" => "pomodoris#today"
  match "/yesterday" => "pomodoris#yesterday"

  match "/settings" => "users#edit"
  match "/repeat_tags" => "pomodoris#repeat_tags"
  match "/delete_tag" => "pomodoris#delete_tag"

  match "/get_trello_cards" => "pomodoris#get_trello_cards"
  match "/trello_settings" => "users#trello_settings"

end
