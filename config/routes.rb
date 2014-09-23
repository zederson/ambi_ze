Rails.application.routes.draw do

  root to: "home#index"
  resources :action_colors
  resources :colors

end
