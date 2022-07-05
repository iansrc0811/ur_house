module V1
  module Residences
    class Edit < Grape::API

      before do
        authenticate!
        error!('Access Denied', 401) if !current_user.admin?
      end

      desc "Edit a residence"

      params do
        requires :id, type: Integer, desc: "Residence id"
        optional :city_id, type: Integer, desc: 'City ID'
        optional :district_id, type: Integer, desc: 'District ID'
        optional :room_number, type: Integer, desc: 'Bedroom Number'
        optional :price, type: Integer, desc: 'Price'
        optional :mrt, type: String, desc: 'MRT Line name'
      end

      patch "/residences" do
        residence = Residence.find(params[:id])
        # set include_missing to false to ignore nil value params
        residence.update! declared(params, include_missing: false)
        present residence, with: V1::Entities::Residence
      end
    end
  end
end
