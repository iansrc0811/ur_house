RSpec.shared_context "login admin", :shared_context => :metadata do
  let!(:admin) { create(:admin, email: email, password: password) }
  let(:admin_token) { "Bearer #{Warden::JWTAuth::UserEncoder.new.call(admin, :user, nil)[0]}" }
  let(:email) { 'admin1@test.com' }
  let(:password) { 'password' }
  let(:json_body) { JSON.parse(response.body) }

  before do
    post '/api/v1/user/login', params: { email: email, password: password }
  end
end
