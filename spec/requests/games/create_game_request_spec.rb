require 'rails_helper'

describe 'Game Creation' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:params) {
    {
      game: {
        player_1_id: user_1.id,
        player_2_id: user_2.id
      }
    }
  }

  let(:token_1) { Doorkeeper::AccessToken.new(resource_owner_id: user_1.id) }
  let(:token_2) { Doorkeeper::AccessToken.new(resource_owner_id: user_2.id) }

  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:doorkeeper_token).and_return(token_1)
    allow_any_instance_of(ApplicationController).to receive(:doorkeeper_token).and_return(token_2)
  end

  it 'should allow an authenticated user to create a games with one other user' do
    post api_v1_games_url(params: params)

    expect(response).to be_successful

    game_data = parse_json(response.body)

    expect(game_data[:game][:player_1][:id]).to eq(user_1.id)
    expect(game_data[:game][:player_2][:id]).to eq(user_2.id)
    expect(game_data[:game][:uuid]).to eq(User.first.player_1_games.last.uuid)
    expect(game_data[:game][:uuid]).to eq(User.last.player_2_games.last.uuid)
  end

end