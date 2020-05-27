Rails.application.routes.draw do

  constraints(subdomain: "api") do
    scope module: :api do
      namespace :v1 do
        use_doorkeeper

        resources :users, module: :users, only: %i[create delete show] do
          resources :games, module: :games, only: [] do
            resource :ship_placement, module: :ships, only: %i[create update destroy]
          end
        end

        resources :games, module: :games, only: :create
      end
    end
  end

end
