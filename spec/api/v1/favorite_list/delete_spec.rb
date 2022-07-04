require 'rails_helper'
require 'login_user'
RSpec.describe "V1::FavoriteList::Add", type: :request do
  include_context "login user"

  let(:taipei_city) { create(:city, :taipei) }
  let(:district_1) { create(:district, name: '大同區', city: taipei_city) }
  let(:residences) do
    create_list(:residence, 2, city: taipei_city, district: district_1, room_number: 2, price: 10002, mrt: 'blue')
  end

  describe 'delete residence from favorite_list' do
    subject(:delete_from_favorite_list) do
      delete '/api/v1/favorite_lists/delete', params: { residence_ids: residences.pluck(:id) }, headers: { "Authorization" => token }
    end

    before do
      user.residences = residences
    end

    it 'delete residences successfully' do
      expect { delete_from_favorite_list }.to change { user.favorite_lists.reload.count }.from(2).to(0)
      expect(user.residences.reload).to be_empty
    end
  end
end
