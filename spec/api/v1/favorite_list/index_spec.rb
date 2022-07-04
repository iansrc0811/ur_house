require 'rails_helper'
require 'login_user'
RSpec.describe "V1::FavoriteList::Index", type: :request do
  include_context "login user"

  let(:taipei_city) { create(:city, :taipei) }
  let(:district_1) { create(:district, name: '大同區', city: taipei_city) }

  before do
    create_list(:residence, 30, city: taipei_city, district: district_1, room_number: 2, price: 10002, mrt: 'blue')
    user.residences = Residence.all
  end

  describe 'get favorite_list' do
    subject(:get_favorite_list) do
      get '/api/v1/favorite_lists', headers: { "Authorization" => token }
    end

    it "list favorite_list without filter conditions" do
      get_favorite_list
      expect(json_body.size).to eq(25) # default is 25 items per_page
      first_25_items_id = user.residences.order("id desc").limit(25).map(&:id)
      expect(json_body.map{|item| item["id"]}).to eq(first_25_items_id)
    end
  end
end
