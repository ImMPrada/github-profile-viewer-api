Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resource :health, only: [:show], controller: :health
      resource :profile, only: [:show], controller: :profile
    end
  end
end
