Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :health, only: [:show], controller: :health
      resources :profiles, only: [:show]
    end
  end
end
