require 'rails_helper'

describe 'Game Play API' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let(:token_1) { Doorkeeper::AccessToken.new(resource_owner_id: user_1.id) }
  let(:token_2) { Doorkeeper::AccessToken.new(resource_owner_id: user_2.id) }

  context :validate_shots do
    it 'should raise an error for invalid coordinates' do
      allow_any_instance_of(ApplicationController).to receive(:doorkeeper_token).and_return(token_1)

      game = create(:game, player_1: user_1, player_2: user_2)
      ship_params = {
        ships: {
          patrol: %w[A11],
          cruiser: %w[B1 B2],
          submarine: %w[C1 C2 C3],
          battleship: %w[D1 D2 D3 D4],
          carrier: %w[E1 E2 E3 E4 E5]
        }
      }
      post v1_user_game_ship_placement_url(user_id: user_1.id, game_id: game.id), params: ship_params

      expect(response).to be_successful

      game_data = parse_json(response.body)

      expect(game_data[:status]).to eq(404)
      expect(game_data[:message]).to eq('You have placed one of your ships incorrectly. Please limit selections to adjacent cells withing the defined board.')
    end

    it 'should place ships if valid coordinates' do
      allow_any_instance_of(ApplicationController).to receive(:doorkeeper_token).and_return(token_1)

      setup
      game = create(:game, player_1: user_1, player_2: user_2)
      ship_params = {
        ships: {
          patrol: %w[A1],
          cruiser: %w[B1 B2],
          submarine: %w[C1 C2 C3],
          battleship: %w[D1 D2 D3 D4],
          carrier: %w[E1 E2 E3 E4 E5]
        }
      }
      post v1_user_game_ship_placement_url(user_id: user_1.id, game_id: game.id), params: ship_params

      expect(response).to be_successful

      game_data = parse_json(response.body)
      require 'pry'; binding.pry

    end
  end
end