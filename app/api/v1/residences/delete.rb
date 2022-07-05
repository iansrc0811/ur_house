module V1
  module Residences
    class Delete < Grape::API

      before do
        authenticate!
        error!('Access Denied', 401) if !current_user.admin?
      end

      desc "Delete a residence"

      params do
        requires :id, type: Integer, desc: 'Residence ID'
      end

      delete "/residences" do
        residence = Residence.find(params[:id])
        error!('Residence not found', 404) if residence.blank?
        residence.destroy!
        { message: 'destroy successfully' }
      end
    end
  end
end
