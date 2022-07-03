require 'rails_helper'
require 'login_user'
require 'login_admin'
RSpec.describe "V1::Residences::Delete", type: :request do

  let!(:residence) { create(:residence) }
  describe 'Delete residence' do

    context "when login user is not admin" do
      include_context "login user"
      subject(:delete_residences) do
        delete '/api/v1/residences',
          params: { id: residence.id },
          headers: { "Authorization" => token }
      end
      it "raise error" do
        delete_residences
        expect(response.status).to eq(401)
        expect(json_body["error"]).to eq("Access Denied")
      end
    end

    context "when login admin" do
      include_context "login admin"
      subject(:delete_residences) do
        delete '/api/v1/residences',
          params: { id: residence.id },
          headers: { "Authorization" => admin_token }
      end
      it "delete successfully" do
        expect { delete_residences }.to change { Residence.all.reload.count}.by(-1)
        expect(response.status).to eq(200)
        expect(json_body["message"]).to eq("destroy successfully")
      end

      context "when residence not found" do
        subject(:delete_residences) do
          delete '/api/v1/residences',
            params: { id: Residence.last.id + 1 },
            headers: { "Authorization" => admin_token }
        end

        it "raise error" do
          delete_residences
          expect(json_body["error"]).to eq("Record Not Found")
        end
      end
    end
  end
end
