Rails.application.routes.draw do

  root to: "home#index"
  resources :action_colors,  except: [:show]
  resources :colors, only: [:index]
end
