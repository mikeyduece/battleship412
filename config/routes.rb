Rails.application.routes.draw do

  use_doorkeeper
  namespace :api do
    namespace :v1 do

      resources :users, module: :users, only: %i[create delete show] do
        resources :games, module: :games, only: [] do
          resource :firing_solution, module: :ships, only: :update
          resource :ship_placement, module: :ships, only: :create
        end
      end

      resources :games, module: :games, only: :create
    end
  end

end
