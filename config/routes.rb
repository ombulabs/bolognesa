Bolognesa::Application.routes.draw do

  root to: 'welcome#index'

  resources :users do
    resources :pomodoris
  end

  match "/auth/:provider/callback" => "sessions#create"
  match '/auth/failure', :to => 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout

  match "/pomodoris/create" => "pomodoris#create"

end
