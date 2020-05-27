module Api
  module V1
    module Users
      module Games
        module Ships
          class ShipPlacementsController < BaseGameController

            def create
              Api::V1::Games::Ships::Create.call(current_api_user, @game, ship_params) do |success, failure|
                success.call { |resource| success_response(ship: serialized_resource(resource, Games::Ships::ShipBlueprint)) }
                failure.call(&method(:error_response))
              end
            end

            def ship_params
              params.require(:ships).permit!
            end

          end
        end
      end
    end
  end
end
