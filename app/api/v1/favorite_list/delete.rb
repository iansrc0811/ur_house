module V1
  module FavoriteList
    class Delete < Grape::API

      before do
        authenticate!
      end

      desc "Delete residence from user's favorite list"

      params do
        requires :residence_ids, type: Array, allow_blank: false, desc: 'residence_ids'
      end
      delete "/favorite_lists/delete" do
        current_user.delete_residence_from_favorite(ids: params[:residence_ids])
        residences = current_user.residences.distinct
        present residences, with: V1::Entities::Residence
      end
    end
  end
end
