module V1
  module Residences
    class Index < Grape::API

      before do
        authenticate!
      end

      desc "Get residences information by page (default 1) and per_page (default 25)"

      params do
        optional :city_id, type: Integer, desc: 'City ID'
        optional :district_id, type: Integer, desc: 'District ID'
        optional :room_number, type: Integer, desc: 'Bedroom Number'
        optional :price_min, type: Integer, desc: 'Price range min'
        optional :price_max, type: Integer, desc: 'Price range max'
        all_or_none_of :price_min, :price_max, message: "must be provided together"
        optional :mrt, type: String, desc: 'MRT Line name'
      end
      get "/residences" do
        residences =
          Residence.filter_by(
            city_id: params[:city_id],
            district_id: params[:district_id],
            room_number: params[:room_number],
            price_min: params[:price_min],
            price_max: params[:price_max],
            mrt: params[:mrt])
            .pagination(params[:page] || 1, params[:per_page] || 25)
        present residences, with: V1::Entities::Residence
      end
    end
  end
end
