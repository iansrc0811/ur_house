require 'rails_helper'
require 'login_user'
RSpec.describe "V1::Residences::Index", type: :request do
  include_context "login user"

  let(:taipei_city) { create(:city, :taipei) }
  let(:new_taipei_city) { create(:city, :new_taipei) }
  let(:district_1) { create(:district, name: '大同區', city: taipei_city) }
  let(:district_2) { create(:district, name: '三重區', city: new_taipei_city) }

  before do
    create_list(:residence, 10, city: taipei_city, district: district_1, room_number: 2, price: 10002, mrt: 'blue')
    create_list(:residence, 30, city: new_taipei_city, district: district_2, room_number: 3, price: 10003, mrt: 'yellow')
  end

  describe 'get residences' do
    subject(:get_residences) do
      get '/api/v1/residences', params: params, headers: { "Authorization" => token }
    end

    context 'when query with no filter conditions' do
      let(:params) { {} }
      it "list residences without filter conditions" do
        get_residences
        expect(json_body.size).to eq(25) # default is 25 items per_page
        first_25_items_id = Residence.order("id desc").limit(25).map(&:id)
        expect(json_body.map{|item| item["id"]}).to eq(first_25_items_id)
      end
    end

    context 'when query with filter conditions' do
      let(:params) do
        {
          city_id: taipei_city.id,
          district_id: district_1.id,
          room_number: 2,
          price_min: 10000,
          price_max: 12000,
          mrt: 'blue',
          page: 1,
          per_page: 30
        }
      end

      it 'filters by condition' do
        get_residences
        expect(json_body.size).to eq(10) # 10 items match conditions
        expect(json_body.all? {|item| item["mrt"] == 'blue'}).to be_truthy
        expect(json_body.all? {|item| item["room_number"] == 2}).to be_truthy
      end

      it "get no items when no match conditions" do
        params[:price_min] = 11000
        get_residences
        expect(json_body.size).to eq(0)
      end

      describe 'with error params' do
        context 'when price_min > price_max' do
          it "return error messages" do
            params[:price_min] = 12000
            params[:price_max] = 11000
            get_residences
            expect(response.status).to eq(400)
            expect(json_body["error"]).to eq("price_min must be less than price_max")
          end
        end

        context 'when one price_min if provided but price_max is not' do
          it "return error messages" do
            params.delete(:price_max)
            get_residences
            expect(response.status).to eq(400)
            expect(json_body["error"]).to eq("price_min, price_max must be provided together")
          end
        end
      end

    end
  end
end
