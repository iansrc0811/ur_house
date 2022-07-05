require 'rails_helper'
require 'login_user'
RSpec.describe "V1::User::VerifyTokenStatus", type: :request do
  include_context "login user"
  subject(:verify_token) do
    get '/api/v1/user/verify_token_status',
      headers: { "Authorization" => token }
  end


  context 'when token is still valid' do
    it 'return user' do
      verify_token
      expect("Bearer #{json_body["jwt"]}").to eq(token)
      expect(json_body["full_name"]).to eq(user.full_name)
    end
  end

  context 'when token is invalid' do

    it 'raise error' do
      User.revoke_jwt(nil, user)
      verify_token
      expect(response.status).to eq(401)
    end
  end
end
