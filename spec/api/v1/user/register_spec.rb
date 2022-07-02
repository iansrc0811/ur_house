require 'rails_helper'
RSpec.describe "V1::User::Register", type: :request do
  let(:email) { 'user1@test.com' }
  let(:password) { 'password' }
  let(:json_body) { JSON.parse(response.body) }

  context 'when register is successful' do
    it 'creates new user' do
      expect do
        post '/api/v1/user/register', params: { email: email, password: password }
      end.to change(User, :count).by 1
    end

    it 'responses the new created user' do
      post '/api/v1/user/register', params: { email: email, password: password }
      expect(json_body['email']).to eq(email)
    end

    it 'responses with jwt authorization token' do
      post '/api/v1/user/register', params: { email: email, password: password }

      expect(response.headers['Authorization']).to match /(^[\w-]*\.[\w-]*\.[\w-]*$)/
    end

    context 'when email is already registered' do
      let!(:user) { create(:user, email: email)}

      it 'responses with error message' do
        post '/api/v1/user/register', params: { email: email, password: password }
        expect(response.status).to eq(401)
        expect(json_body['message']).to eq('User Already Exists')
      end
    end

    context "when missing params" do
      it 'responses with error message' do
        post '/api/v1/user/register', params: { email: email }
        expect(response.status).to eq(400)
        expect(json_body['message']).to eq('No email or password provided')
      end
    end
  end
end
