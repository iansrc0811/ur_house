require 'rails_helper'
require 'login_user'
RSpec.describe "V1::District::Index", type: :request do
  include_context "login user"

  let(:taipei_city) { create(:city, :taipei) }
  let(:districts) { create_list(:district, 10, city: taipei_city) }


  describe 'get districts' do
    subject(:get_districts) do
      get '/api/v1/districts', headers: { "Authorization" => token }
    end

    it "list favorite_list without filter conditions" do
      get_districts
      expect(json_body.size).to eq(10)
    end
  end
end
