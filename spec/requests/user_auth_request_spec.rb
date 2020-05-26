require 'rails_helper'

describe 'User Authentication' do
  let!(:params) {
    {
      "user": {
        "first_name": "Test",
        "last_name": "McTesterson",
        "email": "email@email.com",
        "password": "password"
      }
    }
  }

  let(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }

  it 'should create user through the API' do
    expect(User.count).to eq(0)

    post v1_users_path(params: params)

    expect(response).to be_successful

    user_data = parse_json(response.body)

    expect(user_data[:user][:first_name]).to eq('Test')
    expect(User.last.first_name).to eq('Test')
    expect(User.count).to eq(1)
  end
end