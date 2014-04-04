Bolognesa::Application.routes.draw do

  root to: 'welcome#index'

  resources :users do
    resources :pomodoris
  end

  resources :pomodoris

  match "/auth/:provider/callback" => "sessions#create"
  match '/auth/failure', :to => 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout

  match "/pomodoris" => "pomodoris#index"
  match "/pomodoris/create" => "pomodoris#create"
  match "/pomodoris/set_finished" => "pomodoris#set_finished"
  match "/pomodoris/set_tags" => "pomodoris#set_tags"
  match "/today" => "pomodoris#today"
  match "/yesterday" => "pomodoris#yesterday"

  match "/settings" => "users#edit"

end
