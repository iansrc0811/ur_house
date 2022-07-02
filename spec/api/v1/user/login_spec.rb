require 'rails_helper'
RSpec.describe "V1::User::Login", type: :request do
  subject(:login) { post '/api/v1/user/login', params: { email: email, password: password }}

  let(:email) { 'user1@test.com' }
  let(:password) { 'password' }
  let(:json_body) { JSON.parse(response.body) }
  let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)[0]}


  describe 'login is successful' do
    let!(:user) { create(:user, email: email, password: password) }
    it 'login' do
      login
      expect(response.header["Authorization Bearer"]).to eq(token)
    end
  end

  context 'when login is unsuccessful' do
    describe 'email is not found' do
      let(:email) { 'no_exist@test.com' }
      it "return 'Invalid Email'" do
        login
        expect(json_body["message"]).to eq('Invalid Email')
      end
    end

    describe 'password is incorrect' do
      subject(:login) { post '/api/v1/user/login', params: { email: email, password: 'incorrect password' }}
      let!(:user) { create(:user, email: email, password: password) }

      it "return 'Invalid Email'" do
        login
        expect(json_body["message"]).to eq('Invalid Password')
      end
    end
  end
end
