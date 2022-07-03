require 'rails_helper'
require 'login_user'
RSpec.describe "V1::User::Logout", type: :request do
  include_context "login user"
  subject(:logout) do
    headers = { "Authorization" => token }
    delete '/api/v1/user/logout', params: {}, headers: headers
  end

  describe 'logout is successful' do
    it 'logout' do
      expect { delete '/api/v1/user/logout', params: {}, headers: { "Authorization" => token } }.
      to change {user.reload.jti}
    end
  end

end
