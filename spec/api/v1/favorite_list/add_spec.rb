require 'rails_helper'
require 'login_user'
RSpec.describe "V1::FavoriteList::Add", type: :request do
  include_context "login user"

  let(:taipei_city) { create(:city, :taipei) }
  let(:district_1) { create(:district, name: '大同區', city: taipei_city) }
  let(:residences) do
    create_list(:residence, 2, city: taipei_city, district: district_1, room_number: 2, price: 10002, mrt: 'blue')
  end

  describe 'add residence to favorite_list' do
    subject(:add_to_favorite_list) do
      post '/api/v1/favorite_lists/add', params: { residence_ids: residences.pluck(:id) }, headers: { "Authorization" => token }
    end

    it 'add residences to list' do
      expect { add_to_favorite_list }.to change { user.favorite_lists.reload.count }.from(0).to(2)
      expect(user.residences.pluck(:id)).to contain_exactly(*residences.pluck(:id))
    end
  end
end
