module V1
  module FavoriteList
    class Add < Grape::API

      before do
        authenticate!
      end

      desc "Add residence to user's favorite list"

      params do
        requires :residence_ids, type: Array, allow_blank: false, desc: 'residence_ids'
      end
      post "/favorite_lists/add" do
        current_user.add_residence_to_favorite(ids: params[:residence_ids])
        residences = current_user.residences.distinct
        present residences, with: V1::Entities::Residence
      end
    end
  end
end
