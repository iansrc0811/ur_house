RSpec.shared_context "login user", :shared_context => :metadata do
  let!(:user) { create(:user, email: email, password: password) }
  let(:token) { "Bearer #{Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)[0]}" }
  let(:email) { 'user1@test.com' }
  let(:password) { 'password' }
  let(:json_body) { JSON.parse(response.body) }

  before do
    signin
    # call token explicitly to get current token
    token
  end

  def signin
    post '/api/v1/user/login', params: { email: email, password: password }
  end
end
