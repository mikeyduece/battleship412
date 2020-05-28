module Api
  module V1
    module Users
      module Games
        module Ships
          class FiringSolutionsController < BaseGameController

            def update
              Api::V1::Games::Ships::Update.call(current_api_user, @game, params) do |success, failure|
                success.call {|resource| success_response(game: serialized_resource(resource, ::Games::GameBlueprint, user: current_api_user))}
                failure.call(&method(:error_response))
              end
            end

          end
        end
      end
    end
  end
end