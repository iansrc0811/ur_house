module V1
  module Residences
    class Show < Grape::API

      before do
        authenticate!
      end

      desc "Get residences information)"

      params do
        requires :id, type: Integer, desc: "Residence id"
      end

      get "/residences/:id" do
        residence =
        Residence.find(params[:id])
          .as_json(
            only:[
              :id,
              :address,
              :mrt,
              :price,
              :room_number,
              :title
            ],
            methods: :image_url,
            include: {
              city: { only: [:id, :name] },
              district: { only: [:id, :name] }
              }
          )
        present residence, with: V1::Entities::Residence
      end
    end
  end
end
