module V1
  module FavoriteList
    class Index < Grape::API

      before do
        authenticate!
      end

      desc "Get user's favorite list of residences by page (default 1) and per_page (default 25)"

      get "/favorite_lists" do
        residences = current_user.residences
          .pagination(params[:page] || 1, params[:per_page] || 25)
        present residences, with: V1::Entities::Residence
      end
    end
  end
end
