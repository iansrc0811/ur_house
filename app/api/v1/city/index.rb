module V1
  module City
    class Index < Grape::API

      before do
        authenticate!
      end

      desc "Get city list"

      get "/cities" do
        cities = ::City.all.as_json(only: [:id, :name])
        present cities, with: V1::Entities::City
      end
    end
  end
end
