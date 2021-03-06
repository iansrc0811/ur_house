module V1
  module Residences
    class Index < Grape::API

      before do
        authenticate!
      end

      desc "Get residences information by page (default 1) and per_page (default 25)"

      params do
        optional :city_id, type: Integer, desc: 'City ID'
        optional :district_ids, type: Array, desc: 'District ID'
        optional :room_number, type: Integer, desc: 'Bedroom Number'
        optional :price_min, type: Integer, desc: 'Price range min'
        optional :price_max, type: Integer, desc: 'Price range max'
        all_or_none_of :price_min, :price_max, message: "must be provided together"
        optional :mrt, type: String, desc: 'MRT Line name'
        optional :page, type: Integer, desc: 'Page number for pagnination'
        optional :per_page, type: Integer, desc: 'Number of items per page'
      end

      get "/residences" do
        residence_list =
          Residence.list(
            city_id: params[:city_id],
            district_ids: params[:district_ids],
            room_number: params[:room_number],
            price_min: params[:price_min],
            price_max: params[:price_max],
            mrt: params[:mrt],
            page: params[:page],
            per_page: params[:per_page]
          )
        present residence_list, with: V1::Entities::ResidenceWraper
      end
    end
  end
end
