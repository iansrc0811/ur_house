require 'rails_helper'
require 'login_user'
RSpec.describe "V1::District::Index", type: :request do
  include_context "login user"

  let(:cities) { create_list(:city, 11, city: taipei_city) }


  describe 'get cities' do
    subject(:get_cities) do
      get '/api/v1/cities', headers: { "Authorization" => token }
    end

    it "list favorite_list without filter conditions" do
      get_cities
      expect(json_body.size).to eq(11)
    end
  end
end
