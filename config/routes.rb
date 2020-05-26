Rails.application.routes.draw do
  use_doorkeeper

  constraints(subdomain: "api") do
    scope module: :api do
      namespace :v1 do
        resources :users, module: :users, only: %i[create delete show]
      end
    end
  end

end
