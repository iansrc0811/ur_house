require 'rails_helper'
RSpec.describe "V1::User::Logout", type: :request do
  subject(:logout) do
    delete '/api/v1/user/logout', params: { jwt: token }
  end

  let!(:user) { create(:user, email: email, password: password) }
  let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)[0]}
  let(:email) { 'user1@test.com' }
  let(:password) { 'password' }
  let(:json_body) { JSON.parse(response.body) }


  describe 'logout is successful' do
    before do
      post '/api/v1/user/login', params: { email: email, password: password }
      @token = response.header["Authorization Bearer"]
    end
    it 'logout' do
      expect { logout }.to change {user.reload.jti}
    end
  end

end
