require 'rails_helper'
require 'login_user'
require 'login_admin'
RSpec.describe "V1::Residences::Edit", type: :request do

  let!(:residence) { create(:residence) }
  describe 'Edit residences' do

    context "when login user is not admin" do
      include_context "login user"
      subject(:edit_residences) do
        patch '/api/v1/residences',
          params: { id: residence.id },
          headers: { "Authorization" => token }
      end
      it "raise error" do
        edit_residences
        expect(response.status).to eq(401)
        expect(json_body["error"]).to eq("Access Denied")
      end
    end

    context "when login admin" do
      include_context "login admin"
      subject(:edit_residences) do
        patch '/api/v1/residences',
          params: params,
          headers: { "Authorization" => admin_token }
      end
      let(:new_city) { create(:city) }
      let(:new_district) { create(:district) }
      let(:params) do
        {
          id: residence.id,
          room_number: 100,
          price: 123,
          mrt: 'red',
          city_id: new_city.id,
          district_id: new_district.id
        }
      end
      it "update successfully" do
        expect { edit_residences }.to change { residence.reload.mrt }.to('red')

        expect(response.status).to eq(200)
        expect(residence.room_number).to eq(100)
        expect(residence.price).to eq(123)
        expect(residence.mrt).to eq('red')
        expect(residence.city).to eq(new_city)
        expect(residence.district).to eq(new_district)
      end

      context "when residence not found" do
        subject(:edit_residences) do
          patch '/api/v1/residences',
            params: { id: Residence.last.id + 1 },
            headers: { "Authorization" => admin_token }
        end

        it "raise error" do
          edit_residences
          expect(json_body["error"]).to eq("Record Not Found")
        end
      end
    end
  end
end
