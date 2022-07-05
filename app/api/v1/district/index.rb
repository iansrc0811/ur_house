module V1
  module District
    class Index < Grape::API

      before do
        authenticate!
      end

      desc "Get distrcit list"

      get "/districts" do
        districts = ::District.all.as_json(only: [:id, :name, :city_id])
        present districts, with: V1::Entities::District
      end
    end
  end
end
