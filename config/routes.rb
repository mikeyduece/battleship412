Rails.application.routes.draw do

  constraints(subdomain: "api") do
    scope module: :api do
      namespace :v1 do
        use_doorkeeper

        resources :users, module: :users, only: %i[create delete show]
        resources :games, module: :games
      end
    end
  end

end
